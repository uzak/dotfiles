#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Author   : Martin Užák <martin.uzak@gmail.com>
# Creation : 2017-01-02 16:57
# File     : ttt.py

"""
plain text file based Time Tracking Tool
"""

import argparse
import functools
import logging
import datetime
import collections
import re

# TODO split formatting from computting


# default date formats
DATE_FMT     = "%Y-%m-%d"
TIME_FMT     = "%H:%M"
DATETIME_FMT = DATE_FMT + " " + TIME_FMT


class Time_Interval:
    """ Model a time interval on the same day.

    >>> ti = Time_Interval("2016-11-21", "11:11", "14:04")
    >>> ti
    2016-11-21 11:11 - 14:04
    >>> int(ti)
    173
    >>> ti = Time_Interval("2016-11-21", "9", "14:05")
    >>> ti
    2016-11-21 09:00 - 14:05
    >>> int(ti)
    305
    """

    def __init__(self, date, time_from, time_to):
        # normalize input:
        # add minutes if missing
        add_min_fmt = "%s:00"
        if not ":" in time_from:
            time_from = add_min_fmt % time_from
        if not ":" in time_to:
            time_to = add_min_fmt % time_to

        # initialize
        fmt        = "%s %%s" % date
        self.date  = date
        self.start = datetime.datetime.strptime(fmt % time_from, DATETIME_FMT)
        self.end   = datetime.datetime.strptime(fmt % time_to, DATETIME_FMT)

    def __int__(self):
        "return the difference of `self.start` to `self.end` in minutes"
        return (self.end - self.start).seconds // 60

    def __repr__(self):
        return "%s %s - %s" % (
            self.date,
            self.start.strftime(TIME_FMT),
            self.end.strftime(TIME_FMT))
    __str__ = __repr__


class Time_Value:
    """Model a time value composed of any number of hours and minutes

    >>> tv = Time_Value("5h 10m")
    >>> tv
    5h10m
    >>> int(tv)
    310
    >>> tv = Time_Value("130m")
    >>> tv
    2h10m
    >>> int(tv)
    130
    """
    def __init__(self, value):
        if "h" in value:
            hours, mins = value.split("h")
            hours = int(hours.strip())
        else:
            hours = 0
            mins = value
        self.hours = hours
        self.mins = 0
        if mins:
            self.mins = int(mins.split("m")[0])
        while self.mins >= 60:
            self.mins -= 60
            self.hours += 1

    def __int__(self):
        "return the difference of `self.start` to `self.end` in minutes"
        return self.hours * 60 + self.mins

    def __repr__(self):
        if self.mins:
            return "%dh%dm" % (self.hours, self.mins)
        return "%dh" % (self.hours)
    __str___ = __repr__


class Entry:
    def __init__(self, date, value, cost_center, desc):
        self.date        = date
        self.value       = value
        self.cost_center = cost_center
        self.desc        = desc

    def __repr__(self):
        return "%s %13s %6s %s" % \
                (self.date.strftime(DATE_FMT),
                 self.value,
                 self.cost_center,
                 self.desc)
    __str__ = __repr__


def create_cost_center(project, phase):
    return "%s:%s" % (project, phase)


# line parser
DATE        = r"(\d{1,}-\d{1,2}-\d{1,2})"
TIME        = r"(\d{1,2}(?::\d{1,2})?)"
TIME_VALUE  = r"(?:(?:" + TIME + r"\s*-\s*" + TIME + r")|(\d+h(?:\s?\d+m)?|\d+m))"
PRJ_ABBR    = r"(\w+)"
PHASE       = r"(\d+)"
COST_CENTER = PRJ_ABBR+":"+PHASE
DESCRIPTION = r"(.*)"
LINE_PAT    = re.compile \
    (
        DATE +
        r"\s+"
        + TIME_VALUE +
        r"\s+"
        + COST_CENTER +
        r"(?:\s+" + DESCRIPTION + ")?"
    )


class InvalidInputError(ValueError):
    def __init__(self, file, line, message):
        super(InvalidInputError, self).__init__()
        self.file    = file
        self.line    = line
        self.message = message

    def __str__(self):
        return "%s:%s> %s" % (self.file, self.line, self.message)


class TTT:
    "Time Tracking Tool"

    def __init__(self, from_date=None, to_date=None):
        self.data      = []
        self.from_date = self._make_date(from_date)
        self.to_date   = self._make_date(to_date)

    def read(self, filename):
        # read input data
        with open(filename, 'r') as f:
            for i, line in enumerate(f):
                self.parse_line(line, filename, i)

        # filter out all data outside of requested interval (from_dt, to_dt)
        if self.from_date:
            self.data = filter(lambda x: x.date >= self.from_date.date(), self.data)
        if self.to_date:
            self.data = filter(lambda x: x.date < self.to_date, self.data)

    def parse_line(self, line, filename, line_no):
        "Parse `line` from `filename` and return an `Entry` object if possible"
        line = line.strip()

        # get rid of comments
        line = line.split("#")[0]

        if line:
            m = LINE_PAT.match(line)
            if m:
                date, start, end, val, prj, phase, desc = m.groups()
                date = datetime.datetime.strptime(date, DATE_FMT).date()
                cc   = create_cost_center(prj, phase)
                if start and end:
                    val = Time_Interval(date, start, end)
                else:
                    val = Time_Value(val)
                entry = Entry(date, val, cc, desc)
                self.data.append(entry)
            else:
                raise InvalidInputError(filename, line_no, line)

    def output_csv(self):
        for monthly in self.by_months(self.data).values():
            for by_cc in self.by_cost_center(monthly).values():
                year   = by_cc[0].date.year
                month  = by_cc[0].date.month
                cc     = by_cc[0].cost_center
                values = [int(r.value) for r in by_cc]
                total  = functools.reduce(lambda a, b: a+b, values)
                print("%d,%d,%s,%d" % (year, month, cc, total))

    def output_human_readable(self, norm=None):
        "output read data in human readable form"
        data = self.data
        fmt = "\t{:<10} {:>10}"

        # print month by month stats
        for month, entries in self.by_months(data).items():
            print("* %s" % month)
            for cc, entries_by_cc in self.by_cost_center(entries).items():
                print(fmt.format(cc, self.sum(entries_by_cc)))
            print(fmt.format("=>", self.sum(entries)))
            print()

        # print totals
        data = list(data) #XXX
        if data:
            start = min(data, key=lambda x: x.date)
            end = max(data, key=lambda x: x.date)
            print("%s..........%s" % (
                start.date.strftime(DATE_FMT), end.date.strftime(DATE_FMT)))
            print("-" * 30)
            for cc, entries_by_cc in self.by_cost_center(data).items():
                print(fmt.format(cc, self.sum(entries_by_cc, norm=norm)))
            print("=" * 30)
            print("Total %+23s" % self.sum(data))


    def sum(self, data, norm=None):
        """return human readble sum of all values in data"""
        val = 0
        for row in data:
            val += int(row.value)

        h = val // 60
        m = val % 60
        result = "{:>3}h".format(h)
        if m:
            result +=" {:>2}m".format(m)

        if norm is not None:
            dates = set()
            for entry in data:
                dates.add(entry.date)
            working_dates = [d for d in dates if d.isoweekday() <= 5]
            target_min = val - (len(working_dates) * norm * 60)
            if target_min == 0:
                return result
            if target_min > 0:
                fmt = " (+%s min)"
            else:
                fmt = " (%s min)"
            result += fmt % target_min
        return result

    def by_cost_center(self, data):
        """split `data` by cost centers and return as dictionary"""
        result = collections.OrderedDict()
        for row in sorted(data, key=lambda x: x.cost_center):
            cc = row.cost_center
            if cc not in result:
                result[cc] = []
            result[cc].append(row)
        return result

    def by_months(self, data):
        """return `data` grouped by months"""
        result = collections.OrderedDict()
        for row in sorted(data, key=lambda x: x.date):
            key = "%s %s" % (row.date.strftime("%B"), row.date.year)
            if key not in result:
                result[key] = []
            result[key].append(row)
        return result

    def _make_date(self, strvalue):
        if not strvalue:
            return
        try:
            result = datetime.datetime.strptime(strvalue, DATE_FMT)
        except ValueError:
            raise ValueError("Invalid date value: `%s`" % strvalue)
        return result

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--from_date")
    parser.add_argument("--to_date")
    parser.add_argument("--norm", default=5, type=int, help="daily norm")
    parser.add_argument("filename", nargs="+", help="input text file")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-hr", dest="output_hr", action='store_true')
    group.add_argument("-csv", dest="output_csv", action='store_true')
    args = parser.parse_args()

    logging.debug("args.from_date: %s" % args.from_date)
    logging.debug("args.to_date: %s"% args.to_date)
    logging.debug("args.filename: %s" % args.filename)

    ttt = TTT(from_date=args.from_date, to_date=args.to_date)

    # read input
    for fn in args.filename:
        ttt.read(fn)

    # output
    if args.output_hr:
        ttt.output_human_readable(norm=args.norm)
    elif args.output_csv:
        ttt.output_csv()

if __name__ == "__main__":
    main()
