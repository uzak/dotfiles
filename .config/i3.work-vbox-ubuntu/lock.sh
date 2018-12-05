# https://www.reddit.com/r/i3wm/comments/9ebemt/locking_i3_when_lid_of_laptop_is_closed/
#!/bin/sh
set -e
xset s off dpms 0 10 0
i3lock --color=4c7899 --ignore-empty-password --show-failed-attempts --nofork
xset s off -dpms
