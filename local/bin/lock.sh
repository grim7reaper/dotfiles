#!/usr/bin/sh

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#00ffffcc'
TEXT='#00eeeeee'
WRONG='#880000bb'
VERIFY='#00bbbbbb'

i3lock --nofork --ignore-empty-password \
    --insidever-color=$CLEAR   \
    --ringver-color=$VERIFY    \
    --insidewrong-color=$CLEAR \
    --ringwrong-color=$WRONG   \
    --inside-color=$BLANK      \
    --ring-color=$DEFAULT      \
    --line-color=$BLANK        \
    --separator-color=$DEFAULT \
    --verif-color=$TEXT        \
    --wrong-color=$TEXT        \
    --time-color=$TEXT         \
    --date-color=$TEXT         \
    --layout-color=$TEXT       \
    --keyhl-color=$WRONG       \
    --bshl-color=$WRONG        \
    --blur 5              \
    --clock               \
    --indicator           \
    --time-str="%H:%M:%S"  \
    --date-str="%Y/%m/%d" \
