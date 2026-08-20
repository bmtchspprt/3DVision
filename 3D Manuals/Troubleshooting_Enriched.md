# Troubleshooting — manuals + firmware + software (enriched)

**This is a copy of `Troubleshooting_Manuals.md`, then updated.**  
Do not edit the original manuals file; keep that as the PDF extract. Use **this** file for support logic that also uses closed firmware math and what the live 3D Vision UI actually does.

Firmware math source of truth: `docs/firmware/RESEARCH-CLOSED.md` (firmware `3DLevelScannerM_4_5_452`). Do not invent formulas beyond that file.

**How to read this file:** Formulas stay for the record. Under each one, **Do this in the software** is the version you actually click. You should not need a calculator for `X_m`.

---

## How much this can improve troubleshooting

**Honest range: a lot on diagnosis, some on “what to type,” little on inventing new magic numbers.**

| Layer | What we can add | What we still cannot claim |
|---|---|---|
| **Manuals** | Official UI names, defaults, published mapping walk | No TS chapter; 420/7/8/MPN not in the books |
| **Software (live app)** | Exact Overview warning, dialog options, Demo Mode hiding problems, Load from Vessel, Grades vs Echo Curve series | Demo Mode is not the same as a live Host |
| **Firmware (closed)** | Why a recording reported distance **X**; Grade vs Threshold pick; maps do **not** skip *this* shot; damping is **not** a metres slew; Echo Curve axis | Why field techs picked **420 / 7 / 8**; bit-identical ADC Grade paint without ADC; AFE mix replay |

**Where the gain is real**

1. **“Why did it report this distance?”** — From a Grades / `.bm4` file: last bin where Grade > Threshold, axis `i × (1000/65536)` m. Tape vs file is now a defined check, not a guess.

   **Do this in the software:** You never type that formula. Open **Device → Echo Curve Analysis…** (or **Echo Curve Analyze Viewer…** for a saved file). Bottom axis is already distance from the scanner. Find where the **blue Echo** line last sits **above** the **green Threshold**. Read that number on the bottom scale (switch the unit box to **ft** if the tape is in feet). That number **is** `X_m` (or feet). Compare it to the tape. Also click **Load from Vessel** and read **Avg Distance** on Overview — same idea, live.

2. **False-echo myths** — Mapping does **not** make the unit skip that peak on the shot that produced the orange/reported distance. Maps feed **later** Threshold. Wiping maps (Reset User and Auto) is a **reset**, not the book’s Manual Scan fix, and it will not “uncross” the pick that already happened.

   **Do this in the software:** After mapping, run Echo Curve **again** (or wait and Load from Vessel). The **pink User False Echo** / **red Auto False Echo** lines should move; the old screenshot will not change. To wipe: **Device → Device False Echo Mapping…** → Action Type **Reset User and Auto False Echoes** → **Reset Mapping** → Close. To map a spike: Action Type **Manual Scan**, type **From** / **To** from the Echo Curve bottom axis (spike range only, not the tape distance), **Start Scanning**.

3. **Damping myths** — Output Damping Time is **not** `new_metres = old + d·(new−old)`. Raising 300 → 420 can still help **stability / SNR in product behavior**, but do not explain a stuck metre as “damping hasn’t caught up” in that IIR sense. The software book’s “wait one damping time after mapping” is still the right **operational** wait (algorithm / history window), not firmware metres slew.

   **Do this in the software:** **Device → Advanced Parameters…** → **Output Damping Time**. Default **300**. Field SNR-0 path types **420**. **Upload All**, **Close**. After mapping, wait that many seconds (300 or 420), then **Load from Vessel** and check SNR / distance. Do not sit there expecting the metres field to crawl toward the tape like a slider.

4. **Echo Curve vs Grades** — Same physics family. Echo Curve series: Echo (Grade), Threshold, Auto False Echo, User False Echo, Fuzzy. Grades Analysis is the **named** tool in the 2013 book. Teach both names; do not treat Echo Curve as a different product.

   **Do this in the software:** **Device → Echo Curve Analysis…**. Legend: Echo (blue), Threshold (green), Auto False Echo (red), User False Echo (pink). Optional **Show Fuzzy**. Book name **Grades Analysis** is the same job if that menu is what the site PC has.

5. **SNR 0** — Firmware/software: below Minimal SNR (**13 dB** default) the reading **does not update**. Overview can show **Device in Low SNR**. SNR 0 is echo loss / no valid pick, not “damping field empty.” Field 420/7/8 is a **tech recipe** on top of that; keep it labeled as field, not factory.

   **Do this in the software:** **Load from Vessel**. Read Overview **SNR** (want above ~13). If **Device in Low SNR** or **0.00**: field path is AP **Output Damping Time 420**, **Max Filling Rate 7**, **Max Emptying Rate 8**, **Upload All**, **Close**, then False Echo **Reset User and Auto**, **Reset Mapping**, Close, Load from Vessel again, watch SNR. Do not lower **Minimal SNR** below 10 unless senior tech said so (Advanced Parameters, senior-only).

6. **Stuck full** — Dead band **0.5 m / 1.64 ft** plus Top Dead Band **Don’t Discard** presenting full-calibration distance when the echo is closer. That is stronger than “type 1.64” alone.

   **Do this in the software:** **Device → Device Configuration Wizard…** → Next to **Full / Empty Calibration**. Set **Distance (Top)** to at least **1.64** (ft). **Finish**. Then **Load from Vessel**. In Advanced Parameters, **Top Dead Band** = **Don’t Discard** means a too-close echo is shown as full — leave it unless support told you otherwise.

7. **Mounting / Locator** — Center and wall-adjacent installs create symmetric / wall echoes that look like false echoes. Axis points in the wizard are X, Y, Z from center, **feet**. 30° slope: measure **horizontal ÷ 0.866** down the slope.

   **Do this in the software:** Wizard → **dimensions** → **Next** — the three axis numbers are X, Y, Z from center in **feet**. You type the tape values; you do not run cosine in the app. For a 30° hopper, convert on paper first (see slope action below), then type that longer slope distance into placement — not the horizontal-only number.

8. **PC sleep** — Still not in the 3D books; still a real Host disconnect cause. Keep it.

   **Do this in the software:** Nothing in 3D Vision. On the **Host** PC: Start → power → **Make my device sleep after** = **Never**. Then reconnect / Load from Vessel.

**Where we should not oversell**

- Do not rebuild Threshold from Grade (`T[i] = c·Grade[i]` is false).

   **Do this in the software:** Leave **Threshold** on Echo Curve as the green line the scanner already sent. Do not try to “fix” it by typing a Grade multiplier. To change detection, use **CFAR Sensitivity** / **User or Auto False Echo Sensitivity** (default **1.2**) in Advanced Parameters, **Upload All** — or map From/To. Never invent `T = 1.2 × Echo` in a spreadsheet and expect the box to match.
- Do not say “this AFE/False E bin made firmware skip that peak” for the orange/reported pick.

  **Do this in the software:** Red/pink explain **later** Threshold, not the orange mark on the file you already opened. Take a **new** Echo Curve after mapping.

- Do not replay AFE mix (uninitialized mix addend).

  **Do this in the software:** Do not try to “rebuild” Auto False Echo by hand. **Reset Auto** or reset-all, then let the scanner rebuild. New Echo Curve to see red.

- Do not treat demo Echo Curve envelopes as ADC-true Grade.

  **Do this in the software:** On a live Host, run **Echo Curve Analysis** after Load from Vessel. Demo trainer charts are for teaching the legend, not tape match.

- Do not replace field 420/7/8 with a firmware-derived substitute — there isn’t one in the closed notes.

  **Do this in the software:** Keep typing **420 / 7 / 8** when that is the site recipe. Firmware does not give a different box to fill.

**Practical effect on the install-guide TS list:** we can make the **stories and wait/conditions** correct (what the warning is, what Reset Mapping does, what Echo Curve lines mean, when to Load from Vessel). We should **not** pretend firmware proved the numeric recipe. Best improvement is a **decision tree** (below) plus honest labels on field numbers.

---

## Sources

| File | What it is | Dated / notes |
|---|---|---|
| `Software Manual.pdf` | 3DVision / 3DMultiVision operating instructions | © 2013 BinMaster, 73 pages. No troubleshooting chapter. |
| `Hardware Manual.pdf` | 3DLevelScanner operating / install | © 2023 BinMaster, 42 pages. No troubleshooting chapter. |
| `Multi-point Measurement Refresher.pdf` | Sales / “how 3D works” | 8 pages. Not a service document. |
| `docs/firmware/RESEARCH-CLOSED.md` | Closed pick / axis / maps / damping | Firmware 4.5.452 |
| Live 3D Vision (this guide’s MultiVision) | Overview problems, False Echo Mapping window, Echo Curve legend | Match the real app, not Demo-only chrome |

Page numbers below for manuals are **PDF / printed pages** as in `Troubleshooting_Manuals.md`.

---

## How this relates to the install-guide troubleshooting list

The current guide topics are **field procedures plus UI walkthroughs**. The manuals describe **how the software and scanner work**. Firmware tells **what a recording actually picked**.

| Guide topic | Manual | Enriched (firmware + live software) | Verdict |
|---|---|---|---|
| SNR Reading is 0 | Below Minimal SNR: no new measure; damping improves SNR; rates = process | Overview **Device in Low SNR**. SNR 0 = no valid Grade>Threshold (or response not OK). 420/7/8 = field, not firmware. After Upload All: **Close AP**, then mapping wipe, then Load from Vessel. | **Keep recipe, relabel it.** Add warning + SNR 0 on Overview. |
| Sensor full / Distance (Top) 1.64 | Full cal default 0.5 m (1.64 ft); dead band 50 cm | Don’t Discard presents **full cal distance** when echo is closer. Hardware “16"” is a bad conversion of 500 mm. | **Yes.** Explain lock-at-full, not only the number. |
| Wizard dead-zone | Same | Same + material in horn = hardware damage / garbage Grade | **Yes.** |
| Reset after mapping | Restart ~30 s, rebuilds auto maps + damping. Not Factory. | Restart is a **new search**, not a temperature event. 20 mA = 100% output, not reboot proof. After restart: wait, then Load from Vessel. | **Fix the “proofs.”** |
| Controller sleep | Not in manuals | Host PC sleep drops RS-485/TCP polling. Screen-off ≠ sleep. | **Keep.** |
| Auto Beam Selection | Default auto; ≥3 **consecutive** dirs; Auto Range separate | 9 beams: High/Med/Low + Dir 30…330. Auto Range = orange line on Grades. Uncheck **both** autos in AP review if forcing all beams. | **Add consecutive-3 + Auto Range.** |
| How to read Echo Curve | Book name is **Grades Analysis** | Echo = Grade (blue), green Threshold, red Auto False Echo, pink User False Echo, black Fuzzy. X = distance from scanner (not “level”). Tight cluster at tape distance = good; isolated near spike = false. **Pick = last Grade > Threshold**, maps ignored on that pick. | **Teach Echo Curve as Grades, with series names.** |
| Reset Sensor Mapping | Reset All False Echoes / Reset Mapping | Opcode family: Scan / Manual Scan / resets. User map is a **327-pt** stored series. Wipe ≠ Manual Scan From/To. After wipe, auto map rebuilds (and Restart rebuilds too). | **Keep wipe as a topic; add Manual Scan as the book fix.** |
| Advanced Parameters review | Close discards; Auto FE default Enable | First five AP values must match all scanners in a vessel. Upload All vs one device. Disable Auto FE **freezes last auto image**; wipe then sets auto map to 0. | **Partly.** Don’t say “always disable” without why. |

**Numbers that are field practice, not manual or firmware values**

- Output Damping Time **420** (manual default **300 s**, minimum **60 s**)

  **Do this in the software:** Advanced Parameters → **Output Damping Time** → type **420** → **Upload All** → **Close**.

- Max Filling Rate **7** / Max Emptying Rate **8** (manual default **10**; “set to actual process”)

  **Do this in the software:** Same window: **Max. Filling Rate** **7**, **Max. Emptying Rate** **8** → **Upload All**. If the silo fills faster than that, the live level will lag — that is expected.

- **MPN Rate** (not named in these manuals; not in closed firmware notes under that name)

  **Do this in the software:** If the site sheet says MPN 7, it may be a field nickname — do not hunt a box labeled MPN. Use Filling/Emptying **7** / **8** as in the SNR-0 trainer unless a senior tech named a different field.

- False-echo **threshold 12000** — book **example** only

  **Do this in the software:** Only when Action Type is **Manual Scan**. Type **Threshold** in False Echo Mapping (example 12000). On **Reset** actions that box stays **-** and is disabled.

- Windows sleep = **Never**

  **Do this in the software:** Not in 3D Vision. Host PC power settings.

---

## Decision tree (enriched)

Use this order on a live call. It is manuals + firmware + UI, not a new numeric recipe.

1. **Grey / no values** — comms, poll 00–63 unique, Host not asleep, not Demo, Server on Host only. Load from Vessel does nothing useful if disconnected.

   **Do this in the software:** Overview LED grey → **Connect**. Parameters tab: COM / poll. Toolbar **Load from Vessel** only after green.

2. **Device in Low SNR / SNR 0 or “-”** — treat as **no valid pick** (Grade never beat Threshold, or SNR &lt; Minimal SNR 13 dB). Check horn/dust/dead zone **before** typing AP. Then field damping/rates if that is the site standard. Then maps.

   **Do this in the software:** Load from Vessel. Overview **SNR** and **Device in Low SNR**. Echo Curve: if Echo **never** stays above Threshold, mapping/AP will not invent a peak — clean the horn first. Then the 420/7/8 + reset-maps path.
3. **Reads full / 20 mA / tape much farther** — Distance (Top) ≥ 1.64 ft; Don’t Discard lock; material in blanking; **or** a **near false echo** that Grade&gt;T at a small `i` (pick is **last** G&gt;T — a far real echo can still win if it also exceeds T; a **only-near** spike with nothing past T reports near/full).

   **Do this in the software:** Overview: note **Avg Distance** and **Output**. Open Echo Curve: if Echo only beats Threshold in the **first ~1.6 ft**, fix wizard Distance (Top). If Echo beats Threshold at a spike **before** the tape mark and **not** at the tape mark, use False Echo **Manual Scan** From/To on that spike. Toolbar **Load from Vessel** after either change.

4. **Tape vs software distance disagree but SNR OK** — one-point tape ≠ 3D average/volume. Compare tape to **Echo/Grades distance axis**, not to volume %. From a `.bm4`: `X_m = last_i × (1000/65536)`.

   **Do this in the software (this is how you “use” X_m):**  
   1. On Overview, switch the view to **Distance** (not Volume %).  
   2. **Load from Vessel**. Read **Avg Distance** — that is the live report.  
   3. **Device → Echo Curve Analysis…**, set units to **ft** or **m** to match the tape.  
   4. On the chart, the bottom number where **Echo last stays above Threshold** is `X_m` / `X_ft`. You read it; you do not calculate `last_i × 1000/65536`.  
   5. If Avg Distance ≈ that chart number but both disagree with **volume %**, the 3D surface is doing its job — tape is one point.  
   6. Saved file: **Device → Echo Curve Analyze Viewer…**, open the `.bm4`, same read of the axis.

5. **False echo suspected** — Grades/Echo Curve: spike closer than tape. **Manual Scan** From/To per the book, **or** wipe maps if the site procedure is reset-all. Wait **one Output Damping Time** before judging. Do not tell the customer the map “deleted that peak on the shot already taken.”

   **Do this in the software:** Echo Curve → zoom the near spike (drag a box; **Zoom Undo** if you go too far). Read From/To off the bottom axis. **Device False Echo Mapping…** → **Manual Scan** → type those two numbers → **Start Scanning**. Wait (see damping seconds on AP). New Echo Curve: **pink** line in that band. Then Load from Vessel.

6. **After any upload/map/reset** — Close the dialog, **Load from Vessel**, wait damping window, then look at SNR and distance.

   **Do this in the software:** Toolbar **Load from Vessel**. Then Overview **SNR** and **Avg Distance**. If Advanced Parameters is still open, **Close** it first so you are not looking at stale typed fields.

---

## Firmware — only the closed bits that change support talk

Full math: `docs/firmware/RESEARCH-CLOSED.md`. Short version for troubleshooting:

**Reported distance from a Grades file**

You do **not** need to run this. The scanner and Echo Curve already did it. Plain English: walk the blue Echo line from **left (near horn) to right (farther)**; the **last place it is still above the green Threshold** is the reported distance `X_m`.

```
dh = 1000 / 65536          // metres per Grade index
G[i] = GradeAmp[i] × 1.01
T[i] = ThresholdAmp[i >> 2]
last_i = last index with G[i] > T[i]
X_m  = last_i × dh
```

**Do this in the software**

| Formula piece | What you click |
|---|---|
| `last_i` | Echo Curve: last crossing of **Echo** over **Threshold**, reading **right-to-left along the bottom axis** (farthest “still above green”) |
| `dh` / `1000/65536` | Already built into that bottom axis. Set the unit dropdown to **m** or **ft**. |
| `G[i] × 1.01` | Already inside the **Echo** line. Do not type 1.01 anywhere. |
| `T[i >> 2]` | Already the **Threshold** line (green). Do not resample it by hand. |
| `X_m` | That bottom-axis number, **or** Overview **Avg Distance** after **Load from Vessel** |

- Orange / reported encoding uses that `last_i` when the gate writes it.

  **Do this in the software:** If the chart shows an orange/reported marker, that is the pick. If not, use Echo vs Threshold as above.

- **This pick does not read Auto False Echo or User False Echo.**

  **Do this in the software:** You can hide/show **red** and **pink** in the legend. Turning them off does not change Avg Distance. Mapping only matters on the **next** Load from Vessel / next Echo Curve.

- AFE can change **later** Threshold, not this pick.

  **Do this in the software:** After Auto False Echo runs, take a **new** Echo Curve. Green Threshold may have moved. Compare the new bottom-axis pick to the tape.

- User False Echo is a stored series (Manual Scan fills it). Peak helper does not load it.

  **Do this in the software:** **False Echo Mapping** → **Manual Scan** → From/To → **Start Scanning**. Then new Echo Curve: pink line in that From/To band. Then **Load from Vessel**.

- **Do not** say damping slews reported metres.

  **Do this in the software:** Change **Output Damping Time**, Upload All, wait that many seconds, Load from Vessel. Distance should **jump or hold**, not ease like a progress bar.

- **Do not** rebuild T from Grade.

  **Do this in the software:** Never type a Threshold from Echo×constant. Use **False Echo Sensitivity 1.2** fields or mapping From/To.

**Echo Curve axis (support)**

- Horizontal: distance from the **scanner** (m or ft), `h(i) = offset + i × resolution` (file header), same family as `i × dh` when offset is 0.

  **Do this in the software:** Echo Curve toolbar unit **m** / **ft**. Zoom (drag). Read feet or metres off the **bottom**. That **is** `h(i)`. Offset/resolution are in the file header — the chart already applied them.

- Lines start high energy on the **left** (near the sensor) and run toward farther range on the **right**. “Lower levels” in the current guide text is easy to misread as fill % — it is **farther from the horn**.

  **Do this in the software:** Left of the chart ≈ **1.64 ft dead zone**. Right ≈ empty / far. Do not compare the right edge to Overview **volume %**.

**Series lengths (so charts are not “wrong”)**

| Series | Role on Echo Curve | Do this in the software |
|---|---|---|
| Grade / Echo | Pulse-compressed amplitude (up to 5242 pts) | Look at **Echo** (blue). |
| Threshold | Detection floor used by the pick | Look at **Threshold** (green). Pick = Echo last above it. |
| Auto False Echo | Coarser map (655 pts); max-hold vs Grade in the proven path | **Red** line. Built by the scanner; **Reset Auto** / reset-all clears it. |
| User False Echo | Manual map (327 pts) | **Pink** line. **Manual Scan** draws it. **Reset User** clears it. |
| Fuzzy | Software overlay on selected echoes | Check **Show Fuzzy** on the Echo Curve toolbar. |

| Series | Role on Echo Curve |
|---|---|
| Grade / Echo | Pulse-compressed amplitude (up to 5242 pts) |
| Threshold | Detection floor used by the pick |
| Auto False Echo | Coarser map (655 pts); max-hold vs Grade in the proven path |
| User False Echo | Manual map (327 pts) |
| Fuzzy | Software overlay on selected echoes |

**False Echo Mapping actions (live software, matches firmware command family)**

- Reset User and Auto False Echoes / Reset User / Reset Auto
- Scan (From/To automatic)
- Manual Scan (From/To + threshold)

Reset Mapping vs Start Scanning: button label follows whether the action is a reset.

---

## Software Manual — facts that matter for troubleshooting

### Users and who can change what

Software p. 63–64.

| Level | Default login | Can do |
|---|---|---|
| Administrator | `admin` / `admin` | Almost everything **except** scanner configuration, communication, polling address |
| Senior Technician | `stech` / `techS` | Full device config, wizard, advanced parameters, beam-specific mapping |
| Technician | `tech` / `tech` | View, vessels, **limited** advanced parameters |
| Viewer | — | View only |

Technician vs Senior Technician: complete Advanced Parameters set is for Senior Technician. APM/BinMaster says consult support before changing parameters.

If **Users Authorization is Enabled** is unchecked, anyone gets administrator privileges with no password.

**Enriched:** Install-guide troubleshooting must run as a user who can open Device → Advanced Parameters and False Echo Mapping (stech). Viewer/Admin-without-device-rights cannot complete those topics.

### Server vs client

- Install **Server** on the Host / controller PC. Do **not** install Server on remote PCs (slow).
- Remote PCs: **Client only**.
- One license code per Server.
- Firewall / router: open the TCP ports the installer documents (software p. 12 area) for LAN client-to-server.
- **Show Server Last Error** (Tools) retrieves the last error from the server.

**Enriched:** Clients cannot connect scanners. “Grey forever on Client” → fix Host. Sleep on the **Host** kills polling; sleep on the Client only drops the viewer.

### Toolbar / Device menu (names the walkthroughs should use)

- **Load from Vessel** — download measurements from all scanners on the selected vessel (updates Overview).
- **Load from Vessels** — all vessels.
- **Connect / Disconnect** vessel or scanner.
- **Device → Advanced Parameters…** (F3)
- **Device → Device False Echo Mapping…**
- **Device → Grades Analysis…** / **Grades Analysis Viewer…**
- **Device → Echo Curve** (live app; same Grade/Threshold/maps family as Grades)
- **Device → Device Activation…** (reset options)
- Close on Advanced Parameters **discards** changes that were not uploaded.

**Enriched:** After Upload All, **Close Advanced Parameters** before opening False Echo Mapping (guide already does this for SNR 0). Mapping window is **459×375**, Device row, Action Type, From/To/Threshold disabled (“-”) on reset actions.

### Overview alerts (condition colors)

Software p. 64–65. Shown on vessel chips, site boxes, and Overview.

| Color | Meaning |
|---|---|
| Grey | No connection |
| Orange | Wrong configuration warning |
| Red | Serious equipment malfunction (usually scanners) |
| Green | OK |

**Text alerts**

- **Red system notification:** measured temperature outside **−40 °C to +85 °C** (−40 °F to +185 °F). This is **not** a “device just rebooted” message.
- **Yellow configuration:** scanner settings ≠ vessel wizard settings (all wizard settings **except** device position and horizontal angle). Text above the vessel image, yellow.
- **Volume alert:** site vessel box turns **red** when volume is above max or below min thresholds (if those thresholds are set).

**Enriched (live app):** Overview problems line can show **Device in Low SNR** when measured SNR is below Minimal SNR (default 13), including SNR **0**. **Demo Mode in the 2013 vessel Overview path clears problem text** — a trainer must force SNR 0 + the warning or the topic is a lie. Do not use a red temperature banner as reboot confirmation.

### SNR and echo loss

Software p. 45–47.

- **Minimal SNR** default **13 dB**. Below this, the sensor **does not measure** and the **reading stays unchanged**. Setting Minimal SNR **below 10 dB is not recommended**.
- **Output Damping Time** — history window; **increases stability and improves SNR**. Default **300 s**, minimum **60 s**. Increase for large MVL systems with **more than 2 scanners**.
- **Exceeding Filling Rate After Echo Loss** (default Yes): when SNR is below Minimal SNR, the algorithm **assumes filling**; when SNR returns it may **exceed** the filling-rate limit to catch up to the real level.

**If SNR is 0 / stuck:** treat as echo loss (Minimal SNR). Manual levers: damping (higher), process fill/empty rates, then **Grades + mapping** if false echoes. There is **no** published “type 420 / 7 / 8” recipe.

**Enriched:** Firmware pick does not apply SNR as a clip inside the Grade-vs-Threshold helper. Product still **holds last reading** when SNR &lt; Minimal SNR — that is why Overview looks “frozen” then jumps when Exceeding Filling Rate After Echo Loss is Yes. Field 420 is “more history / more stability,” not a firmware IIR on metres.

### Full / empty / dead band (wrong full, locked level)

Software wizard step 4 (printed p. 22).

- Full calibration = 100% / **20 mA**. Empty = 0% / **4 mA**.
- Can set as **Distance from top** or **Level from bottom**.
- Full default **0.5 m (1.64 ft)** from the scanner.
- **Dead band is 50 cm (1.64 ft) from the top of the scanner horn.**
- Empty default = bottom of the vessel.

**Top Dead Band** (Advanced Parameters, default **Don’t Discard**):

- **Discard:** ignore echoes closer than full calibration (only when mapping short distances is not possible).
- **Don’t Discard:** still scan inside full calibration; if measured distance is **smaller than full calibration**, the **full calibration distance is presented** (reads as full).

That last line is the software explanation of a **stuck-full** reading when material is in the dead zone / inside full calibration.

**Enriched:** A near false echo that still exceeds Threshold can also pull the **last G&gt;T** pick toward the horn. Dead-zone lock and false-echo pick are different causes of “reads full.” Echo Curve: if energy is only in the first ~1.6 ft, it is blanking/horn; if a spike sits at 5 ft and tape is 12 ft, it is mapping.

### Filling / emptying rates and capacity

- **Max Capacity** default 100 (mass).
- **Max Emptying Rate** / **Max Filling Rate** default **10** (mass/hour).
- Set these to the **actual process**. Too low → algorithm cannot follow real fill/empty. Too high → noisier / less stable tracking.

**Enriched:** 7 and 8 are **slower than default 10**, i.e. more conservative tracking — typical field “quiet it down” with 420 damping. If the silo truly fills faster than 7, the live reading will lag; that can look like SNR/mapping failure.

**Do this in the software:** Advanced Parameters → **Max. Filling Rate** / **Max. Emptying Rate**. Type **7** and **8** for the SNR-0 field path, or the real process rates. **Upload All**. Then Load from Vessel and watch whether level **lags** the process (rates too low) vs SNR still 0 (not a rate problem).

### False echoes — two different operations

Software p. 45–47 (parameters) and p. 57–59 (mapping window).

**Auto False Echo** (default Enable)

- Disable **stops continuous auto calculation** and **keeps the last false-echo image**.
- If false echoes are **manually reset**, the level is set to **0**.

**User False Echo** (default Enable)

- Disable makes the scanner **ignore** the user’s manual map.

**Sensitivities** (default **1.2** each)

- Decrease if mapped false echoes **block the true level**.
- Increase if false echoes are **not ignored**.
- Firmware T rewrite uses **× 1.2** in the closed Threshold walk — same 1.2 family as the sensitivity default. Do not invent other multipliers.

  **Do this in the software:** Advanced Parameters → **User False Echoes Sensitivity** and **Auto False Echoes Sensitivity**. Leave **1.2** unless a spike is eating the true level (lower a little) or maps are ignored (raise a little). **Upload All**. Do not type 1.2 into False Echo Mapping Threshold unless you are doing **Manual Scan** and the book example (~12000) — that Threshold field is a **map height**, not this 1.2.

**False Echo Mapping window** (`Device → Device False Echo Mapping…`)

- Pick **Device**.
- Beams: all beams, or any combination. Senior Technician can map **all or a specific beam**.
- **Action Type** (2013 wording):
  - **Scan** — automatic mapping between **From** / **To**
  - **Manual Scan** — constant threshold between From / To
  - **Reset All False Echoes** — delete **auto + user** maps
- Button: **Start Scanning** or **Reset Mapping** (label depends on action). Starts calculation; window stays in that flow.

Software UI today uses: Reset User and Auto False Echoes / Reset User False Echoes / Reset Auto False Echoes / Scan / Manual Scan — same idea as the 2013 list.

**Published mapping procedure (7.5.1)** — this is the book’s “how to fix false echoes”:

1. Tape or laser: distance from scanner to material. Record it.
2. **Grades Analysis** (`Device → Grades Analysis…`).
3. Grades chart: **X = distance from scanner** (m or ft), **Y = echo energy** (no unit). Vertical lines = echoes.
4. Compare to the tape. Example: tape **12 ft**, echoes in the first **5 ft** → those are false.
5. Zoom (drag a rectangle) to read the exact distance to map.
6. False Echo Mapping: **Manual Scan**, From **0** to **beyond** the false echoes (example **7 ft**), threshold example **12000**.
7. **Start Scanning**. Wait until the in-progress message goes away.
8. Wait a couple of minutes; run Grades again. Confirm **User False Echo (pink)** on the beams that were mapped.
9. Wait **at least one Output Damping Time** before the algorithm fully ignores those echoes.

**Warning in the book:** improper mapping can make the scanner work poorly. This is a brief example, not every case.

**Reset maps** is a **wipe**, not that procedure. After a wipe, Auto False Echo starts over (and a device **Restart** also rebuilds auto false echoes and damping).

**Enriched:** Firmware agrees the **user map is stored** (Manual Scan) and **does not clip this shot’s pick**. Pink line on Echo Curve = user map **for the next Threshold / display**, not “firmware deleted that bin on the recording you already have.” Mapping **the real surface** (From/To covering the tape distance) will hide the true echo — that is the book’s “improper mapping” warning, now with a mechanism: you stored a False E / raised T where Grade of the material lives.

### Grades Analysis vs Echo Curve

Software p. 55–57. There is **no** “Echo Curve” chapter in this book.

- `Device → Grades Analysis…` — collect a chart-type report per scan.
- Tree: Site → Vessel → Scanner.
- **All Grades Info** is the option for analyzing behavior in the vessel.
- **Start** = one shot.
- Continuous: **Every (mins)** 3–1000, default 5; **Duration (hours)** 0.1–999.
- Single scanner → Grades Viewer pops up.
- Viewer: `Device → Grades Analysis Viewer…`
- Tabs per beam (High / Med / Low / dirs); tab disabled if that beam was not active.
- **All Beam** tab: Grade of each beam on one chart.
- Legend: **Grade, CFAR, Auto False Echo, User False Echo, Fuzzy**.
- **Automatic Beams Range** shows as an **orange vertical line** (beam hits the wall / range limit).

For “is this a good echo?”: grouping near the **tape distance** = good; isolated energy **much closer than the material** = false echo to map.

**Enriched:** Echo Curve in the live app is the interactive Grade/Threshold/maps chart (Echo, Threshold, Auto False Echo, User False Echo, Fuzzy). Guide wording should say **distance from the sensor** on the bottom axis. A tight cluster of beam colors = same range on High/Med/Low/dirs. Orange **reported** line (when present) is the pick (`last G>T`), not a wall.

### Beams

Software p. 47–48.

- **Auto Beam Selection** on by default. Algorithm may drop beams from silo size.
- Uncheck Auto Beam Selection to choose manually.
- **High / Med / Low** — three frequencies, all three antennas at once.
- **Dir 30, 90, 150, 210, 270, 330** — six directionals, same frequency as Med.
- Manual pick: **not fewer than three directional beams**, and they must be **consecutive** (example: 30, 330, and 270).
- **Automatic Beams Range** on by default: range limited where the beam hits the wall. Low frequency = wider = more limited. High frequency = narrow = little limit. Algorithm keeps at least one beam that can see the bottom.

**Enriched:** Forcing all 6 dirs + 3 frequencies is a valid **trainer** path when Auto has dropped beams needed for the bottom. Live firmware FFT sizes differ by beam (narrow vs wide). If Auto Range is on, Low may not “see” the bottom — orange line on Grades. Uncheck Automatic Beams Range only when you understand you may paint wall.

### Device Activations (reset)

Software p. 59. `Device → Device Activation…`

| Option | What it does | Does **not** reset |
|---|---|---|
| **Reset (Restart) Device** | Restart DSP. Rebuilds **auto false echoes** and **damping**. ~**30 s**. New search for the correct measurement. | — |
| **Reset to Factory Defaults** | Most parameters to factory. Must re-define almost everything. | **Output Damping Time**, **Steepest Material Slope** |
| **Reset Advanced Parameters and False Echoes** | All advanced parameters (and maps, per title). | Damping, steepest slope, Max Capacity, Max Emptying Rate, Max Filling Rate. **Wizard geometry stays.** |

Pick device(s) in the tree, choose the option, press **Reset**.

Hardware onboard menu (Hardware p. 31) is similar: **Reset** = power-up / clear measurements; **Reset to Factory** = all defaults + reset; **Reset to Lab** = factory password, do not use in the field.

**Enriched:** After Restart, SNR/distance will look wrong until init finishes — that is expected, not a failed map. Historic log sampling also resets to “don’t store.”

### Other Advanced Parameters that show up in “bad reading” calls

Software p. 45–47.

| Parameter | Default | If wrong |
|---|---|---|
| Steepest Material Slope | 35° (use 30–45°) | Echoes that exceed slope are rejected |
| Mechanics Type | II | Wrong type → wrong calculations |
| CFAR Sensitivity | 9 dB | Detection in noise; +6 dB doubles gain |
| Restrain coefficient | 10% | 100% = no preference for near echoes; 0% = first echo wins |
| Side / Bottom Margins | 1 m (3.28 ft) | Tolerance to walls / bottom when dimensions are uncertain |
| Historic Log Sampling | off; 1–60 min | **Resets to default (no log) after power loss or software reset** |

First five AP values must match on **all devices in a vessel**. **Upload all params to all devices** vs **to displayed device**.

**Enriched:** Slope 35° vs a 30° cone: measuring **along the slope** without the 0.866 correction puts the scanner at the wrong XY (see Locator notes). Restrain 10% prefers nearer echoes — combined with a near false echo, it fights mapping. Do not randomly crank CFAR/Minimal SNR below 10 dB.

### Output (4–20 mA) vs displayed volume

Software p. 49–55.

- Output type: Volume (default), Mass, Level, or Distance.
- **20 mA = 100%** of whatever that type is (full calibration for level/volume).
- **4 mA = 0% / empty.**
- After mapping or wizard changes: **Upload All**; if something is invalid, an alert names the problem.
- Book recommends **3DLevelManager** (not 3DVision) for current simulation and firmware upgrade; close Server and Client first.

A **20 mA** reading after reset only means “output at full,” not “reboot succeeded.”

**Enriched:** If output type is Volume, 20 mA can be “full volume” while a tape at one fill point still disagrees. Switch Overview to **Distance** to compare to tape (3–5 ft typical mismatch vs a single-point device is already in the host recap).

### Communications (when Overview is grey / no data)

Software p. 42–45. Hardware wiring p. 20–21.

| Type | Notes |
|---|---|
| **HART** | HART modem on a COM port. **One scanner per COM.** 4–20 mA/HART **must not be multidrop**. |
| **RS-485** | USB/RS-232 converter. Twisted pair, shielded, **120 Ω**, RS-485-rated. Polling address **00–63**, default **00**. |
| **TCP/IP** | RS-485 bridged over IP. Server IP = the serial-to-IP device. |
| **GPRS / GPRS+SMS / Smart GPRS** | 3DLinkPro. Smart GPRS = Senior Technician. |

Scanner is **4-wire, not loop-powered**. Do **not** land supply on 4–20 mA, RS-485, or **PS OUT**.

More than one scanner in a vessel: all need **MVL** license. MV/MVL shows 3D profile.

**Enriched:** Duplicate poll addresses show a conflict in this app. USB converters disappearing after Windows sleep look like “scanner failure.”

### Demo mode

Software p. 63.

- Fast / Normal / Slow run.
- **Must be stopped** before returning to live operation.
- **Exiting the app does not stop demo.**

**Enriched:** Demo Overview historically **clears** problem text. Trainers that need Low SNR must override that. Demo Echo Curve Grade is an envelope, not ADC.

### Multi-scanner / geometry

- Device positions: X/Y from vessel **center**.
- Bottom center can be offset from the body center.
- Wizard Finish uploads to **all scanners in the vessel**.

**Enriched — axis points (tech):** Wizard → dimensions → Next → axis points. Order: **X, Y, Z from center**, units **feet**.

**Enriched — 30° slope:** slope distance = horizontal from center ÷ **0.866**. Example: 10 ft horizontal → ~**11.5 ft** down the slope.

**Do this in the software:** The wizard will not divide by 0.866 for you. On the roof: if Locator / drawing says **10 ft from center** and the lid is a **30°** slope, measure **~11.5 ft along the slope**, then type that into the wizard **axis / placement** fields (feet). Typing 10 when you measured along the slope (or the reverse) puts the sensor in the wrong XY.

---

## Hardware Manual — install problems that look like “software bugs”

### Dead zone / blanking

Hardware p. 10.

- Blanking zone **500 mm**.
- Printed as “500mm (16")” — **16" is wrong**. 500 mm ≈ **19.7 in ≈ 1.64 ft**. Trust the **software** dead band: **0.5 m / 1.64 ft**.

  **Do this in the software:** Ignore the hardware “16"”. In the wizard Full Calibration, **Distance (Top) = 1.64** (when units are ft). Echo Curve: ignore spikes in the first **~1.6 ft** as dead zone, not as a map-to-zero trick unless a tech said to.

If material reaches the **antenna**, buildup in the horn → errors or membrane damage.

Measurements are to the **top of the body**. Neck extension / head-body split: adjust all distances to that reference.

**Enriched:** Grade near index 0 is blanking/horn, not “material at the lid.” Mapping From=0 without a To short of the real surface is how people wipe the top of the curve and the true echo together.

### Mounting (bad echoes, false echoes, no bottom)

Hardware p. 10–13.

- Use Locator software for position.
- **Not next to the wall** — bad performance.
- **Minimum 500 mm from the wall.**
- **Center of the vessel is not recommended** (symmetry makes echoes hard to tell apart).
- Ridge / **00** on the horn (antenna 1) toward **vessel center**.
- Standpipe: antenna must stick out at least **10 mm (0.4")**.
- No rails, frames, or beams in the acoustic beam (includes model S).
- **Not in/above the fill stream**; not looking down a diagonal fill. Need clear line of sight to high material.
- Horns **vertical** to the ground.

**Enriched:** Wall-adjacent + Auto Beams Range → orange line / no bottom. Fill-stream noise → SNR 0 that **mapping will not fix**. Rotate 00 toward center or Grades look rotated vs the 3D image.

### Moisture, wiring, noise

- Cable downward before the gland so water drains.
- Tighten glands; 8–13 mm / 20 AWG typical.
- Screened twisted pair if EMI is expected.
- Ground the chassis.
- Supply **24 VDC**, about **1.5 W**, at the scanner.
- Motors / noisy gear nearby can hurt performance.

**Enriched:** Wet head / dirty horns → Grade looks noisy, Threshold walks up, pick dies (SNR 0). Clean antennas before AP recipes.

### Analog and onboard SNR

Hardware appendix A.

- Onboard **Measured Params** can show Distance, Level, Volume %, Analog Output (mA), **SNR (dB)**, Temperature.
- Example screenshot in the book shows **8.0 dB SNR** — that is **below** software Minimal SNR 13 dB (would not update the reading if Minimal SNR is still 13).
- Output resolution 10 μA; current limit 22 mA.

### Maintenance (chronic bad SNR / drift)

Hardware appendix B.

- Clean **inside the antennas**.
- Check power/comm cables and gland seals.
- Open the rear of the head: **no wetness**.
- Plastic: damp cloth only (static).
- Salt, sugar, calcium carbonate, clingy powders: **more often**.
- Teflon-coated horn (TC models) is for powders that cling.

---

## Multi-point Measurement Refresher

Not a procedure manual. Useful only as the physics story:

- Low-frequency sound → many points on the surface → XYZ → 3D image.
- Volume uses the **surface**, not a single point — tape at one spot will **not** match average / volume exactly (same warning as Software 7.5.1).
- Dust penetration, low dielectric, cone up/down, sidewall buildup.

Do not take beam/false-echo steps from this PDF.

**Enriched:** Firmware Grade is **pulse compression** (matched filter), which is why dust is survivable and why the curve is an envelope along range, not a single ping.

---

## Symptom cheat sheet (manuals + firmware + UI)

| What you see | First checks |
|---|---|
| Grey / no connection | COM, poll 00–63 unique, RS-485 120 Ω, converter, Server on Host, firewall, HART one-per-COM, 4-wire power, **Host not asleep** |
| SNR 0 / Device in Low SNR | Horn/moisture/dead zone; Minimal SNR 13; damping/rates (field); then Grades — **no G>T** |
| Frozen old level, then jump | Echo loss hold + Exceeding Filling Rate After Echo Loss |
| Reads 100% / 20 mA wrongly | Distance (Top) ≥ **1.64 ft**; Don’t Discard lock; horn; **or** near-only Grade>T |
| Tape ≠ volume % | Expected. Compare tape to **Distance** / Grades axis `last_i × dh` |

  **Do this in the software:** Overview → **Distance**. Load from Vessel. Echo Curve bottom axis vs tape. Ignore volume % for this check.
| False echoes / too-high level | Tape vs Grades; Manual Scan From/To **short of the real surface**; wait **one damping time**; do not map the product |
| After mapping, still wrong | Maps don’t change **that** shot; wait damping; Restart (not Factory); Load from Vessel |
| Yellow text on Overview | Scanner wizard ≠ vessel (except position / horizontal angle) |
| Red temperature | Outside −40…+85 °C — **not** a reboot banner |
| Orange indicator | Configuration warning |
| Beams missing / odd range | Auto Beam Selection; Automatic Beams Range (orange line); ≥3 consecutive dirs if manual |
| Log empty after reboot | Historic log sampling resets |
| Demo data / no Low SNR text | Stop Demo; Demo Overview may clear problems |
| Center / wall install, “software broken” | Mounting, not AP |

---

## Install-guide follow-ups (enriched)

Keep `Troubleshooting_Manuals.md` as the PDF-only extract. If the **guide** is updated later:

1. Echo Curve topic: series names + **distance from sensor**; optional pointer that Grades Analysis is the book name.
2. SNR 0: show **0.00** and **Device in Low SNR**; keep 420/7/8 as **field procedure**, not factory defaults; Close AP before mapping.
3. Mapping: Reset User and Auto = **wipe**. Add or split a topic for **Manual Scan** (book 7.5.1).
4. Auto beams: **three consecutive** dirs; Automatic Beams Range called out.
5. Restart: ~30 s + Load from Vessel — drop temperature/20 mA as success checks.
6. Dead zone: **1.64 ft**; mention Don’t Discard lock-at-full.
7. Host sleep: keep.
8. Optional later: `.bm4` / tape vs `X_m = last_i × (1000/65536)` as a **support** tool — not inside the customer trainer unless asked.

   **Do this in the software today:** **Echo Curve Analyze Viewer…** + tape vs bottom axis. No calculator. A dedicated `X_m` box is not in the app.

---

## Pointers (internal)

- PDF extract: `3D Manuals/Troubleshooting_Manuals.md`
- Firmware closed: `docs/firmware/RESEARCH-CLOSED.md`
- Axis / 30° slope: `docs/engineering-notes-axis-slope.md`
)
