# INTERSTELLAR TRAIL — a trading game among the nearest stars

**v1.9.0** — a single-file HTML game (formerly *In Space!*). Open `index.html` in any browser. Progress auto-saves to localStorage; the HALL OF THE GRAND TOUR is a shared online leaderboard (Supabase), with a localStorage fallback when offline.

Silk-Road-style trading loop transplanted to the 20 nearest star systems. The game opens
January 1, **2202** (a small wink to TradeWars 2002). Start at Sol with 2,000 cr, a Taurean
Mule, and an empty (but bottomless) hold.

**The goal is the Grand Tour**: set foot in every settled system (all 23, Vulcan and DS9
included), then return to Sol. Your place in the HALL OF THE GRAND TOUR is ranked by estate
gained per week — (estate on return − starting estate of 4,750 cr) ÷ weeks elapsed, where
estate = credits + hull trade-in value + cargo at local prices. A fast lean run can beat a
slow rich one. The HALL OF THE GRAND TOUR is shared across all players (top 50, via Supabase),
and falls back to a local board if the game is offline or opened from a `file://` path; after
recording you may keep flying. Getting rich remains its own reward.

## The physics (the part that's real)
- **Star positions are real**: J2000 RA/Dec/distance of the 20 nearest systems (incl. the brown
  dwarfs Luhman 16 and WISE 0855−0714) converted to equatorial XYZ in light-years, embedded in `STARS[]`.
- **Brachistochrone transfers**: constant thrust to the midpoint, flip, decelerate. t = 2√(d/a).
- **Thrust is fixed, so acceleration ∝ 1/mass**: hull is 100 mass units; cargo adds mass;
  t = 7 days × √(d/4.37 ly) × √(mass/100). Sol→Alpha Centauri empty = exactly 7 days.
  Time scales with √mass and √distance. Peak velocity = 2d/t (≈456c on the calibration run).
- Relativity is politely ignored (warp-thrust drive, no time dilation).
- **Mid-flight mass changes are kinematically honest.** Any change to thrust-to-mass mid-run
  (salvage taken aboard, cargo lost to pirates, drive faults, hot burns) replans the remainder
  from your exact position and velocity, bang-bang optimal. Take on mass while *decelerating*
  and your braking distance exceeds what's left: you physically cannot stop in time, so you
  brake past the star and fly a second small brachistochrone back — watch the destination
  slide past on the transit screen. Extra time for a pickup at trip fraction f with mass
  ratio r: (T−t)·[r−1+√(2r(r−1))]. That square root is brutal; read the fine print before
  grabbing six ingots of degenerate matter on the decel leg.

## Ships (the Taurean Mule is the calibration reference, 100 mass / 100 thrust)
a = thrust / total mass, so every hull has a load range where it wins: the Classic Flying
Saucer (20/67) is quickest under ~105 cargo mass, the Space Hilux (50/83) under ~195, the
Mule in the middle band, then the Dromedarian Freighter (200/120) takes over at exactly 400, the
Bactrian Hauler (300/132) at 800, and the Conestoga Supermax (400/139) beyond ~1,600.
Specialists: the T'Khasi Orion (25/100) is a Mule-class drive on a quarter-mass racing
hull — exactly twice a Mule's speed empty, ~2x at the classic 40%-load pairing, always
faster than a Mule, but with only Mule-grade absolute thrust the big haulers overhaul it
beyond ~850 cargo mass. No caps anywhere; the hull mass does the balancing. Its price is
derived, not guessed: you are buying power-to-weight, and at 4x a Mule's it costs 4x a
Mule's price = 20,000 cr — landing it beside the Bactrian Hauler, the very ship that
out-hauls it past 800 cargo. Its thoroughbred drive still breaks down ~35% of trips (vs
~12% baseline), and a fault on the deceleration leg means an overshoot; the Argo Class Exploration Vessel (75/75) matches a Mule empty and halves off-route danger; the SSFI
Intergalactic Galliot (150/115) repels 90% of pirate trouble with point-defense. The Escape Pod (10/5)
has half a Mule's power-to-weight and is where you end up when things go wrong.
The shipyard is its own screen, reached by a button from port. Sol's yard stocks every hull at list price but pays a stingy 55% for trade-ins; every
other port runs a used lot with a random weekly selection at 85% of list, paying 75% on
trade-ins. Net worth includes your hull's local trade-in value.

## Piracy is a reputation game
Escape odds are physics: the nav computer rates your chances by your CURRENT thrust-to-mass
(cargo, hull, even mid-trip drive damage all count) — 55% for an empty Mule, ~10% at 1,000
total mass, capped at 95%. And pirates keep books: every ransom you pay raises your "soft
mark" heat (×1.35, up to 3× base frequency); a clean escape works it back down (never below
base); a kill — Intergalactic Galliot point-defense (90%) or the Q-Ship Package's concealed
batteries (67% to obliterate) — drops it BELOW base, to a floor of 0.3×. The Q-Ship Package
(7,500 cr at Sol, select used lots elsewhere) adds 100 hull mass — the hidden guns cost you
real speed — and goes with the hull when you trade or lose it. Cornered and laden, you can
also JETTISON half the cargo (rounded up, per good) and run on the post-dump math: the modal
quotes both sets of odds, and the lightened ship replans the rest of the trip faster too.

## Off the charts
TRANSWARP, a button alongside the regular destinations, reveals a dropdown of ANY system
plus the ENGAGE RECKLESSLY confirmation. Survival
compounds per hub skipped along the normal network: 80% per hub to somewhere you've never
been, 90% per hub if you've set foot there (Argo halves the per-hub risk). Fail the roll
and the ship is destroyed with all cargo; the escape pod kicks free carrying your exact
velocity — the replan machinery takes over, weak brakes, overshoots and all. Pirates can
also torpedo you outright now (25% of failed escapes), same pod, same physics.

## Perishables
Bananas (yes, literally): fine for 60 days, then 90% of remaining units spoil per week.
Bottled flare-plasma (from UV Ceti's flare stars): half-life of 60 days from purchase, no
grace. Both are priced high for the risk; cargo is tracked in dated lots, sold FIFO, and
aged every time the clock advances. The manifest shows the oldest lot's age.

## Planetfall
Five ports offer a landing (or docking): Proxima b, Ross 128 b, Tau Ceti e, Vulcan (where a kal-toh master will beat you graciously at the logic game and send you off with tea), and
the Promenade at DS9. Two days on the surface and a roll on that world's adventure table —
festivals, flare warnings, dabo wheels, logic exams. Rewards and misfortunes are modest
but flavorful.

## The far side of the charts
40 Eridani (16.34 ly) — Vulcan, naturally — hangs off Epsilon Eridani (6.37 ly apart, its
true nearest charted neighbor), and Deep Space 9 sits 52 ly down the same reach, linked
only through 40 Eridani (35.8 ly). Vulcan scientific instruments, Vulcan tea, and Gamma-quadrant curios fetch
spectacular prices back in the bubble.

## The route network (per spec)
From each system you can fly to: the next system *further* from Sol, the next system *nearer*
to Sol, and its own *nearest spatial neighbour* — deduplicated and made symmetric. The result
is a connected 21-node, 31-edge web; junctions like Ross 248 and 61 Cygni get 4 routes.

## The economy
29 sci-fi goods, each with a source system — from featherweight relics (1 mass) up to Groombridge deep-cycle batteries at a spine-crushing 10 mass per rack (Tau Ceti grain, Sirian degenerate-matter ingots,
DX Cancri alien relics — contraband, watch for customs). Price radiates out from each good's source: base × (0.7 + 0.02 × grad × ly-from-source, ly capped at 200) × a
weekly deterministic wobble, where grad rises with weight and perishability — so heavy and spoilable cargo climbs
in value faster with distance (a risk/cost premium), while ordinary goods barely change between neighbours. Stock is deep near the source and thin far away.
Heavy cheap goods vs. light valuables is the core tension, since cargo mass slows the ship.
Each port lists only the goods produced there or sourced nearby (minimum 5), plus whatever
is in your hold — distant exotics must be brought in by someone. Perhaps you.
The bazaar also shows the **average you paid** per good (a lifetime cost basis that survives
selling out, and free salvage lowers it), colored green when the local price is below your basis (buy) and blue when above (sell), so spikes
are visible at a glance. A gold "▲ best price around" tag marks any good whose local price
beats every directly connected neighbor — the signal to stop hauling and start selling.

## Events in transit
Pirates (pay or run), drive faults (+15–35% trip time), smooth vacuum (early arrival),
derelict salvage (credits or cargo — taking cargo slows the rest of the run), trader gossip
(a real, time-limited price spike at a nearby system — now the most common non-pirate event,
so tips flow often), and customs inspections on arrival if you're carrying relics.

Multiple rumors stay active at once (each until its own deadline), they're highlighted in the log, and a **RUMORS** menu at port lists every live tip with your best-known source, leg-jump vs. transwarp travel times, and one-click course plotting.

## The set-out screen
Rotatable 3D starmap (drag to rotate, scroll to zoom, click a highlighted system to depart).
Drop-lines to the Sol plane and 4/8/12-ly reference rings give depth; active routes show
travel time at your current mass. No external libraries — hand-rolled canvas projection.

## The frontier stars (far, far out)
Beyond the settled bubble sit six famous stars at real, punishing distances: Vega and Fomalhaut (~25 ly), Aldebaran (65 ly), then the deep-Orion run of Antares (554 ly), Betelgeuse (640 ly), and Rigel (848 ly, the farthest port on any chart). They hang off the network by a thin thread — the Orion chain runs DS9 → Aldebaran → Betelgeuse → Rigel — so reaching them means a long haul of legs or a reckless transwarp. They are **optional**: the Grand Tour still asks only for the 23 core systems; the frontier is for trade, exploration, and bragging rights. Each stocks a signature export in enormous quantity (Aldebaran whiskey, Rigel starsteel, Betelgeuse dredge-diamonds, Antares heart-garnets, Vega prism-optics, Fomalhaut ring-amber). Rigel's shipyard always has a T'Khasi Orion on the lot.

## Flooding the market
Selling is no longer linear. Each port only has so much appetite for a good at any one time (roughly what it normally stocks). Sell up to that depth and you get full price; dump a huge load beyond it and the per-unit price falls away on a diminishing curve. Load up 150 heavy ingots at Rigel and you'll find no single port can absorb them — you'll spread the sales, and the laden crawl home will feel every light-year.

## Shared scores (Supabase)
The leaderboard rides on the same Supabase project as Silk Road, in its own `inspace_scores`
table so the two boards never mix (Silk Road ranks by estate; Interstellar Trail by ROI/week).
The publishable key embedded in `index.html` is client-safe: row-level security allows public
read/insert/update only, no delete. To (re)create the table, run `supabase_schema.sql` in the
Supabase SQL editor. Each finished voyage upserts one row keyed by a per-run id.

## Hosting / GitHub
Deployed like Silk Road: GitHub Pages serving the latest build as `index.html`, shared scores
via Supabase. Ship the newest versioned file as `index.html`; keep text edits in this source
of truth rather than hand-editing on GitHub, or the two diverge.

Built 2026-07-11 from the Silk Road base-game ideas (nothing in that folder was touched); renamed to Interstellar Trail and given shared Supabase scores on 2026-07-13.
