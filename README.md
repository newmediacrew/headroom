# Headroom

**A status line for Claude Code.** See how much of your usage limits you've used, and when they reset, at a glance.

```
[Opus 5.5] session: 5% (resets 05:30) · week: 7% (resets Wed)
```

- **session** — your 5-hour limit: percentage used and the time it resets
- **week** — your weekly limit: percentage used and the day it resets

## Zero dependencies

Pure bash. No `jq`, no Node, no Python. It needs only `bash` and `date`, which every Mac and Linux machine already has.

## Install

```bash
curl -o ~/.claude/headroom.sh https://raw.githubusercontent.com/newmediacrew/headroom/main/headroom.sh
chmod +x ~/.claude/headroom.sh
```

Then point Claude Code at it in `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/headroom.sh",
    "padding": 0
  }
}
```

The new status line shows up on the next refresh.

## Good to know

- Usage limits are only sent on a Pro or Max subscription, and only after the first response in a session. Until then Headroom shows just the model name.
- Times are shown in your own time zone.
- Works on macOS and Linux. On Windows, use WSL or Git Bash.

## Try it without Claude Code

```bash
echo '{"model":{"display_name":"Opus 5.5"},"rate_limits":{"five_hour":{"used_percentage":42,"resets_at":1792035000},"seven_day":{"used_percentage":7,"resets_at":1792558800}}}' | ./headroom.sh
```

## License

MIT. Not affiliated with or endorsed by Anthropic.
