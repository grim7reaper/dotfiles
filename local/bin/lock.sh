#!/usr/bin/sh

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#00ffffcc'
TEXT='#00eeeeee'
WRONG='#880000bb'
VERIFY='#00bbbbbb'

i3lock --nofork --ignore-empty-password \
    --insidevercolor=$CLEAR   \
    --ringvercolor=$VERIFY    \
    --insidewrongcolor=$CLEAR \
    --ringwrongcolor=$WRONG   \
    --insidecolor=$BLANK      \
    --ringcolor=$DEFAULT      \
    --linecolor=$BLANK        \
    --separatorcolor=$DEFAULT \
    --verifcolor=$TEXT        \
    --wrongcolor=$TEXT        \
    --timecolor=$TEXT         \
    --datecolor=$TEXT         \
    --layoutcolor=$TEXT       \
    --keyhlcolor=$WRONG       \
    --bshlcolor=$WRONG        \
    --blur 5              \
    --clock               \
    --indicator           \
    --timestr="%H:%M:%S"  \
    --datestr="%Y/%m/%d" \
