#!/bin/bash
input=$(cat)

field() {
    local section="${input#*\"$1\"}"
    [ "$section" = "$input" ] && return
    section="${section#*\{}"
    section="${section%%\}*}"
    local pattern="\"$2\"[[:space:]]*:[[:space:]]*(\"([^\"]*)\"|([0-9.]+))"
    [[ $section =~ $pattern ]] && echo "${BASH_REMATCH[2]}${BASH_REMATCH[3]}"
}

format_time() {
    date -r "$1" "+$2" 2>/dev/null || date -d "@$1" "+$2" 2>/dev/null
}

MODEL=$(field model display_name)
FIVE_H=$(field five_hour used_percentage)
FIVE_H_RESET=$(field five_hour resets_at)
WEEK=$(field seven_day used_percentage)
WEEK_RESET=$(field seven_day resets_at)

LIMITS=""
[ -n "$FIVE_H" ] && LIMITS="session: $(printf '%.0f' "$FIVE_H")%"
[ -n "$FIVE_H" ] && [ -n "$FIVE_H_RESET" ] && LIMITS="$LIMITS (resets $(format_time "$FIVE_H_RESET" %H:%M))"
[ -n "$WEEK" ] && LIMITS="${LIMITS:+$LIMITS · }week: $(printf '%.0f' "$WEEK")%"
[ -n "$WEEK" ] && [ -n "$WEEK_RESET" ] && LIMITS="$LIMITS (resets $(format_time "$WEEK_RESET" %a))"

[ -n "$LIMITS" ] && echo "[$MODEL] $LIMITS" || echo "[$MODEL]"
