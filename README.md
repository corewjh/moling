# Moling: Shanhai Talismans 墨灵：山海符录

An original 2D side-scrolling action game inspired by the *Shan Hai Jing* (Classic of Mountains and Seas). Draw talisman glyphs on the touchscreen, chain elements, and place the seal to cast.

**Engine:** Godot 4 (GDScript) · **Platform:** Android first (TapTap)

## Demo scope
- 3 levels: Zhaoyao Mountain (metal/wood/fire) → Qingqiu (+water) → East Sea (+earth)
- 5 classical elements in the demo; thunder and ice come later (7 total)
- Single player, architected for multiplayer later

## Core rules
- 3 rune slots. Drawing only queues glyphs; everything resolves when the seal is placed.
- Fusion recipes (A-B-B-A) are checked first and bypass the damage cap.
- Adjacent counter pairs cancel left to right into one byproduct (water+fire = steam); new neighbours are re-checked.
- Survivors get generation bonuses (+30% per pair, +25% per duplicate), capped at 2x.
- The first surviving element sets the spell shape; the rest add status effects.

## Input
Single-stroke template matching ($1 / Protractor style), lenient recognition, time slows while drawing.

## Architecture
input → command → simulation → presentation. No singleton player (single player = 1-person room), every hit carries a caster id, seeded RNG.

## Status
Design locked for the demo; prototyping the glyph recognizer and the resolver (`scripts/element_rules.gd`).
