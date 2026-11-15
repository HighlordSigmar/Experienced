# Experienced

A customizable experience / reputation bar for the 1.12 client (OctoWoW).

## Install
Put the `Experienced` folder in `Interface\AddOns\`. Disable the Bongos XP bar in the AddOns list at the character screen so you don't get two bars.

## Use
- `/xpb` opens the options window (or right-click the bar)
- Drag the bar to move it while unlocked, then tick "Lock position"
- `/xpb lock`, `/xpb unlock`, `/xpb mode auto|xp|rep`, `/xpb levelup`, `/xpb session`, `/xpb reset`

## What you can change
- Width, height, scale, opacity, number of segments, bar texture, border, spark
- Rested XP overlay, a different color while rested, reputation colored by standing
- Text: always / on mouseover / never; center, left, right, above or below; font, size, outline, short numbers
- All colors, including transparency for the background, overlay, border and segments
- "Auto" mode shows XP while leveling and your watched reputation at 60
- A "You've Reached Level X" banner when you level up, with its own scale and position (drag it while the bar is unlocked)
- Tooltip with rested XP, XP this session, XP per hour, time to level and kills to level

## Text format
Type your own text in the options window (press Enter to apply), or click "Next preset".

XP tokens: `[cur] [max] [rem] [pct] [rested] [restedpct] [lvl] [nextlvl] [bars] [session] [xph] [ttl] [kills]`
Rep tokens: `[name] [standing] [cur] [max] [rem] [pct]`

Text inside `{ }` disappears while a token in it is empty, e.g. `[cur] / [max]{ - [rested] rested}` hides the rested part when you have none.
`[xph]` and `[ttl]` show up after a minute of earning XP; `[kills]` after your first kill.

## Credits
The level-up banner is based on [Vanilla-NewLevelFrame](https://github.com/alchem1ster/Vanilla-NewLevelFrame) by alchem1ster, and uses its banner image (`newlevel_frame.blp`). If you had NewLevelFrame installed, remove it so you don't get two banners.
