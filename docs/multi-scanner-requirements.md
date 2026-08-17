# Multi-scanner options (2 and 3)

When the install guide asks **How many scanners?**, it only shows **2** and **3** if the current wizard dimensions can actually host that many mounts. **1 scanner** is always offered.

This is a **geometry / legal-mount** check. It is not the same as the real app’s “multiple scanners are recommended” warning.

## What the guide uses (show the button)

Locator Calculate (core placement) searches a coarse grid: **15×15** for 2 scanners, **13×13** for 3, **31×31** for 1. A cell is **legal** only if all of these hold (same rules the search uses):

1. **Inside the silo** — distance from center ≤ radius (`D / 2`).
2. **Not too close to the wall** — distance to the wall must be greater than  
   `max(0.7, D / 6)` when `D > 4`, else `max(0.5, D / 4)`  
   (narrow-vessel branch).  
   For a cylinder that means radius of the mount from center `r` satisfies  
   `r < D/2 − wallKeepOut`.
3. **Not too close to a filling point** — distance in XY must be at least  
   `min(max(0.66, D / 10), 2.5)`.  
   If the wizard has no fill row yet, Locator pads a fill at **(0, 0)**, so the hole around center is this keep-out.
4. **Units far enough apart** — min distance between scanners is **radius / 2** = **`D / 4`**.

All of those lengths are in the **wizard Distance unit** (m or ft). Do **not** convert feet to meters before this check or before Calculate. The real app runs the same numeric rules on the numbers the user typed.

### Counts

| Show | Condition |
|------|-----------|
| **1** | Always |
| **2** | At least two legal grid cells with distance ≥ `D/4` |
| **3** | At least three legal grid cells, every pair ≥ `D/4` |

Implementation: `LocatorPlacement.maxSupportedScanners` in `js/locator/exhaustive-search.js`. The wizard exposes `__mvWizMaxSupportedScanners()`. The coach card is built in `scannerCountStepBody()` in `js/install-guide.js`.

### Demo Coke (D = 9, H ≈ 18, Distance = ft)

Legal ring exists (~60 cells on the 15×15 grid). `D/4 = 2.25`. **2 and 3 are shown.**

If you convert 9 ft → ~2.74 m first and then apply the same keep-outs, the legal ring is a few centimeters wide and **misses every grid cell**. Then only **1** would show, and Calculate for 2 would leave both units at 0, 0. That conversion is a bug; do not bring it back.

## What the real app means by “recommended” (do not use for hiding buttons)

The real app can warn that **multiple scanners are recommended** when, in the current unit, with `u` = 1 meter expressed in that unit (`u = 1` in m, `u ≈ 3.2808399` in ft):

- center diameter `D > 15 × u`, **or**
- `totalHeight / D < 2` **and** `D > 7 × u`

That is a **sales / application** hint (wide or very large vessels), not a test of whether Locator can seat 2 units.

Demo Coke in feet (`D = 9`, `H/D = 2`) does **not** trip that warning, but it **does** support 2–3 mounts. The guide follows **support**, not the warning.

## After Calculate

Calculate **is** Locator’s exhaustive search (12-ball hunt, then 50-ball Error Estimation on the chosen mounts). Details: `docs/locator-placement.md` (Core logic).

- Search runs in a **Web Worker** only (`js/locator/placement-api.js`).
- If 2–3 units come back stacked on the same XY (usually 0, 0), treat it as failure — do not continue the guide as if placement succeeded.
- Do not invent geometric guesses (`D/3` around the circle) when Locator finds nothing.

## If you change this

Read `docs/locator-placement.md` first. Keep the legal-cell test in sync with `ValidateScannersLocation` + min distance in `js/locator/exhaustive-search.js`.
