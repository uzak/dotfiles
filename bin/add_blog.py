#!/usr/bin/env python3
"""Create a new blog file and open it in an editor"""

from pathvalidate import sanitize_filename

import argparse
import time
import os
import os

EDITOR = os.getenv('EDITOR', "vi")
BLOG_DIR = os.path.expanduser('~/repos/blog/content/post')

date = time.strftime('%Y-%m-%d')

template = """---
layout: post
title: "%(title)s"
lang: %(lang)s
tags: ['diary']
date: %(date)s
toc: true
---

<!--
    vim:spell spelllang=%(lang)s
-->
"""


def blog_file_name(title):
    t = sanitize_filename(title)
    t = t.replace("'", "")
    return "%s-%s.md" % (date, t.replace(" ", "_"))


def blog_file_name_abs(title):
    return os.path.join(BLOG_DIR, blog_file_name(title))


def main(title, lang):
    fn_abs = blog_file_name_abs(title)
    cmd = "%s '%s'" % (EDITOR, fn_abs)
    print(cmd)

    if os.path.exists(fn_abs):
        raise IOError("File %s already exists" % fn_abs)
    f = open(fn_abs, "w")
    with f:
        d = dict(title=title, lang=lang, date=date)
        f.write(template % d)


parser = argparse.ArgumentParser(description='Add new blog post')
parser.add_argument('title', help='Title for the blog post')
parser.add_argument('-l', '--lang', help='Language of the post', default='sk')

args = parser.parse_args()

main(args.title, args.lang)
