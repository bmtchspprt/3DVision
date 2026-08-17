# Locator placement (this fork)

Read this **before** changing Calculate, scanner count, Device Position rows, or anything under `js/locator/`. Do not re-read the whole tree unless a symptom is not covered here.

Goal: recommended X/Y for 1–3 scanners using the same search the real 3D Vision Locator uses (fuzzy tables + error estimation + exhaustive grid). The install guide calls that search; it must not invent mounts.

## Call path (Calculate)

1. Coach **Calculate** → `applyVesselRecommendedPlacement()` in `js/install-guide.js`.
2. Wizard `applyRecommendedPlacement()` in `js/mv-dialogs.js`.
3. `LocatorPlacement.calculateRecommendedPlacement()` in `js/locator/placement-api.js` (Web Worker **only**).
4. Worker `js/locator/placement-worker.js` `importScripts` the locator modules, then `runPlacementFullFlow`.
5. `runExhaustiveSearch` scores grid combinations; writes `device.Scanners[].ScannerPositionX/Y/Z`.
6. Wizard `setDeviceRows` — Z from roof height at that XY, angle toward center unless “Set device angle manually”.

Never run exhaustive search on the main thread (it freezes the page). Never restore a geometric fallback (even spacing at `D/3`).

## Scripts (load order)

Main page and worker use the same files (see `index.html` and `placement-worker.js`):

| File | Role |
|------|------|
| `constants.js` | Grid sizes (15 for 2 scanners, 13 for 3, 31 for 1), ball counts, error stage limits 3.5 / 4.5 |
| `defs.js`, `balls.js`, `matrix.js`, `algo-error-estimation.js` | Volume / “bad balls” scoring |
| `geometry.js` | Vessel volume helpers + **legal mount** flags (wall, fill, inside silo) |
| `fuzzy.js`, `fuzzy-tables.js` | Fuzzy XML tables (worker has **no DOMParser** — `fuzzy.js` has a tiny parser) |
| `search-radius.js`, `error-estimation-calc.js`, `error-estimation.js` | Per-candidate error |
| `vessel-adapter.js` | Thin vessel/device from wizard numbers; empty fill list → pad **(0, 0)** |
| `exhaustive-search.js` | Grid search, `maxSupportedScanners` |
| `placement-full-flow.js` | Optional 1→2→3 escalate by max error (guide usually locks N) |
| `placement-api.js` | Main-thread worker client (`ready` ping, job ids, cancel) |

Copied into `dist/js/locator/` on `npm run build` so the worker URL still works on GitHub Pages.

## Units (easy to get wrong)

Wizard Distance is **m** or **ft**. The guide forces **ft** for the demo.

Pass **the numbers the user typed** into Locator. Do **not** convert ft → m before search and convert back after.

Search keep-outs mix `D/6`, `D/10` with constants like `0.66` / `0.7`. The real app applies those to the **display** sizes with search `unitsCoeff = 1`. Converting 9 ft to 2.74 m first makes the keep-outs eat the whole silo → **zero legal cells** → both scanners stay at **0, 0**.

`wizardVesselNative()` in `js/mv-dialogs.js` is the correct vessel payload.

## Legal mounts (why 0, 0 happens)

Defaults: scanners start at origin, angle 180°. If the search never writes a better pair, the table stays 0, 0.

A cell is illegal near the wall, near a fill point, or outside the circle. Min spacing between two units is **`D/4`**. Fine pass searches a small window around the rough best; if rough never moved, you still see 0, 0.

If validate finds **no** legal cells, `runExhaustiveSearch` should **throw** (`No legal mount locations…`), not succeed with origin.

Guide scanner buttons: `docs/multi-scanner-requirements.md`.

## Worker gotchas

- Workers here have **no `DOMParser`**. Fuzzy load must use the string parser in `fuzzy.js`.
- Worker must `postMessage({ type: "ready" })` after `importScripts`. Main thread waits (~8 s) then sends `{ type: "calculate", id, vessel, numScanners, … }`.
- Progress: throttle posts (~120–150 ms) or the UI janks.
- `placement-api.js` `scriptBaseUrl` is `js/locator/` relative to the page. Obfuscated `dist/index.html` still needs the copied locator folder.

## Fuzzy type

`GetFuzzyTypeFromGeometry` in `fuzzy.js` picks a table from fill/empty vs center (epsilon = 10% of radius). No fill rows → padded center fill → typically center-fill + center-empty table. Wrong type changes scores, not the 0, 0 “no cells” failure.

## Full flow vs locked N

`runPlacementFullFlow` can start at 1 and add scanners if max error > 3.5 then 4.5. The guide sets `numScanners` and `maxScanners` to the **same** chosen N so Calculate does not escalate.

## What not to do

- Do not “fix” stacked 0, 0 by placing units at `D/3`.
- Do not call `runExhaustiveSearch` from the coach click handler on the UI thread.
- Do not treat the HTML remake in `Documents/3D Emulator/js` as layout/placement truth; match the real app. Speak of “3D Vision” / “the real app” in commits and user-facing docs — never reverse-engineering language.
- Do not skip `npm run build` + dist commit + `git subtree push --prefix dist publish main` after guide JS/CSS/HTML changes.

## Symptoms → likely cause

| What you see | Likely cause |
|--------------|----------------|
| Overlay: `DOMParser required to load Fuzzy XML` | Worker missing XML parser (`fuzzy.js`) |
| Calculate finishes instantly, both at 0, 0 | No legal cells (usually ft converted to m) |
| Overlay error: no legal mount locations | Same, but now thrown on purpose |
| Page frozen, bar at 0% | Search on main thread or progress flood |
| ±D/3 even mounts | Geometric fallback (must stay removed) |
| 2/3 buttons missing on Coke D=9 ft | Support check used meters; should be display units |

## Related docs

- `docs/multi-scanner-requirements.md` — when to offer 2 and 3
- `docs/engineering-notes-axis-slope.md` — installer measuring tips; **not** Locator math
- `.cursor/rules/refer-3d-emulator.mdc` — UI chrome vs real app
- `.cursor/rules/locator-placement.mdc` — pointer at this file
