# Troubleshooting — manuals + firmware + software (enriched)

**This is a copy of `Troubleshooting_Manuals.md`, then updated.**  
Do not edit the original manuals file; keep that as the PDF extract. Use **this** file for support logic that also uses closed firmware math and what the live 3D Vision UI actually does.

Firmware math source of truth: `docs/firmware/RESEARCH-CLOSED.md` (firmware `3DLevelScannerM_4_5_452`). Do not invent formulas beyond that file.

**How to read this file:** Theory stays in place. **Fix in 3D Vision** under a problem is the click path to change the scanner. Sign in as **stech** / **techS** (Senior Technician) or the site’s equivalent — Viewer cannot do these.

---

## Fix in 3D Vision (use these)

Every procedure ends the same way unless noted: **Close** extra windows → toolbar **Load from Vessel** → read Overview **SNR** and **Avg Distance**.

### Fix A — No connection (grey LED, “-”)

1. On the Host PC (not a Client), open the vessel.
2. Toolbar or Parameters: **Connect**. LED must turn **green**.
3. Parameters: **COM port** matches the USB/RS-485 converter; **Polling Address** unique **00–63**.
4. **Load from Vessel**.
5. If it greys out after a few minutes: on the **Host** Windows machine set sleep to **Never** (Start → Power → screen/sleep). Screen-off is OK; sleep is not.

### Fix B — SNR is 0 or Overview says Device in Low SNR

1. **Load from Vessel**. Confirm Overview **SNR** is **0.00** (or under 13) and **Device in Low SNR**.
2. **Device → Advanced Parameters…** (or F3).
3. Set **Output Damping Time** to **420**.
4. Set **Max. Filling Rate** to **7**.
5. Set **Max. Emptying Rate** to **8**.
6. Click **Upload All**. Wait until upload finishes.
7. Click **Close** (do not leave Advanced Parameters open).
8. **Device → Device False Echo Mapping…**
9. **Action Type:** **Reset User and Auto False Echoes**.
10. Click **Reset Mapping**. Wait until the window shows **Completed**.
11. Click **Close**.
12. **Load from Vessel**. Wait up to **420** seconds, then **Load from Vessel** again. If SNR is still 0: clean the horns, then repeat this Load.

### Fix C — Level / 20 mA reads full but the silo is not full

1. **Device → Device Configuration Wizard…**
2. Click **Next** until **Full / Empty Calibration**.
3. On **Distance (Top)** type **1.64** (units must be **ft** on that wizard page).
4. Click **Finish**. Wait for upload.
5. **Load from Vessel**.
6. If it is **still** full: **Device → Echo Curve Analysis…**, set units to **ft**. If a spike sits **before** your tape reading (example spike at 5 ft, tape 12 ft), do **Fix D**. If energy exists only in the first **1.6 ft**, the horn is in the dead zone or dirty — 1.64 is already the software minimum.

### Fix D — False echo (tape says farther than the software)

Tape example from the book: tape **12 ft**, extra echoes in the first **5 ft**.

1. **Device → Echo Curve Analysis…**. Set the unit box to **ft** (or **m** to match the tape).
2. Drag a box around the extra spike (near the **left**). Read the bottom axis: note **From** (start of spike) and **To** (just past the spike, still **short of the tape**). Book example: From **0**, To **7**.
3. Close Echo Curve.
4. **Device → Device False Echo Mapping…**
5. **Action Type:** **Manual Scan**.
6. Type **From** and **To** from step 2.
7. **Threshold:** book example **12000** (only used on Manual Scan).
8. Click **Start Scanning**. Wait until **Completed**.
9. Click **Close**.
10. Wait one **Output Damping Time** (300 s default, or 420 if you set it).
11. **Device → Echo Curve Analysis…** again. **Pink** User False Echo should cover that near band. The real material group should sit near the **tape** distance.
12. **Load from Vessel**. Avg Distance should move toward the tape.

Do **not** set To out to the tape distance — that maps the product and the reading gets worse.

### Fix E — Clear all maps (reset mapping, no Manual Scan)

1. **Device → Device False Echo Mapping…**
2. **Action Type:** **Reset User and Auto False Echoes**.
3. Click **Reset Mapping**. Wait for **Completed**.
4. Click **Close**.
5. Wait one damping time, then **Load from Vessel**.

### Fix F — Auto Beam Selection issues

1. **Device → Advanced Parameters…**
2. Open the **Beams Activation** tab.
3. Uncheck **Auto Beam Selection**.
4. Uncheck **Automatic Beams Range**.
5. Check **High**, **Medium**, **Low**, and **Dir 30, 90, 150, 210, 270, 330** (or **Select All** if the window has it).
6. If you only enable some Dir beams, keep **at least three in a row** (example: 270, 330, 30).
7. **Upload All** → **Close**.
8. **Load from Vessel**.

### Fix G — Sensor “dead” after mapping: restart (not factory)

1. **Device → Devices Activations…** (Device Activation).
2. Leave **Reset (Restart) Device** selected. Do **not** choose **Reset to Factory Defaults**.
3. Click **Reset**. Wait about **30** seconds.
4. Close the window.
5. **Load from Vessel**. SNR and distance will look odd until that 30 s init finishes. **20 mA** only means “output at 100%,” not that the reboot worked.

### Fix H — After mapping, reading still wrong

Maps do not change the old Echo Curve file. Take a new one.

1. Wait one full **Output Damping Time**.
2. **Load from Vessel**.
3. **Device → Echo Curve Analysis…** (new run).
4. If still wrong: **Fix E**, then **Fix G**, then **Load from Vessel**.

### Fix I — Wizard geometry / 30° slope (wrong XY)

1. **Device → Device Configuration Wizard…**
2. Set **Distance** to **ft**.
3. On dimensions, click **Next** until **axis points**. Type **X**, then **Y**, then **Z** from center, in **feet**.
4. If the lid is a **30°** slope and the drawing says **10 ft from center** horizontally: measure **11.5 ft down the slope**, type **that** into placement — not 10.
5. **Finish** → **Load from Vessel**.

### Fix J — Filling/emptying cannot follow the process (level lags)

1. **Device → Advanced Parameters…**
2. **Max. Filling Rate** and **Max. Emptying Rate**: enter the **real** tons (or mass) per hour, not 7/8 if the process is faster.
3. **Upload All** → **Close** → **Load from Vessel**.
4. For the SNR-0 field recipe, use **7** and **8** (Fix B) even if default in the book is 10.

### Fix K — Echo Curve: confirm what the scanner is using (then pick A–D)

1. Toolbar **Load from Vessel**.
2. Overview: use **Distance**, not volume %. Write down **Avg Distance** and **SNR**.
3. **Device → Echo Curve Analysis…**
4. Units **ft** or **m** = same as the tape.
5. **Blue Echo** last staying above **green Threshold** should sit near Avg Distance.
6. Spike **closer than the tape** → **Fix D**. No Echo above Threshold → **Fix B** and clean horns. Cluster only in the first 1.6 ft → **Fix C**.

### Fix L — False echoes keep coming back (freeze auto map)

1. **Device → Advanced Parameters…** → **Advanced** tab.
2. **Auto False Echoes** = **Disable**.
3. **Upload All** → **Close**.
4. If maps are already bad, **Fix E** first, then Disable Auto so it does not rebuild a bad map.

### Fix M — Mapped false echoes are hiding the real level

1. **Device → Advanced Parameters…**
2. **User False Echoes Sensitivity** and/or **Auto False Echoes Sensitivity**: default **1.2**. Lower slightly if the map is eating the true echo; raise slightly if false echoes are still used.
3. **Upload All** → **Close** → **Load from Vessel**.
4. If still wrong, **Fix E** and remap with **Fix D** (To **short of** the tape).

### Fix N — Maps-off scanner check (one beam dead vs false echo vs too close)

Do this **after** a Capture, so you can put the site back. This is not a factory “transducer QA.” Factory reset does not test horns. Grade **is** the hardware output.

1. **Device → Device False Echo Mapping…** → **Reset User and Auto False Echoes** → **Reset Mapping**. Wait for **Completed**. Close.
2. **Device → Advanced Parameters…**
3. **Auto False Echoes** = **Disable** (so Restart does not rebuild the map).
4. Beams tab: uncheck **Auto Beam Selection** and **Automatic Beams Range**. Force **High / Med / Low** and all **six consecutive dirs** (30 through 330).
5. **Upload All** → **Close**. Do **not** run Manual Scan. Do not put mapping back yet.
6. **Fix G** (Restart) if you just wiped maps.
7. Wait one **Output Damping Time**. **Device → Echo Curve Analysis…** → **All Beams**. Walk High / Med / Low, then the six dirs.

Read the curve (do **not** say “definitely punctured”):

| Picture | Possible |
|---|---|
| One or two **dir** tabs grey / flat Grade; sibling dirs still pick near the tape | Receive path on that face disrupted (torn foil/membrane, powder on a speaker, material on one wall of a horn). Inspect that horn. |
| Huge near spike + small dashed pick you can tune off | False echo or material too close — **not** a dead face. The beam still has energy. |
| Energy only in the first **~1.64 ft** on many beams | Dead zone / material in the horn — clean first; the membrane may already be damaged. |
| Noisy Grade on **all** beams, Threshold walked up, SNR 0 | Wet head / dirty horns — clean inside the antennas. |
| All nine weak, or fill only on one side of the silo | Process / placement — do not treat as a dead horn. |
| Auto Range orange line, especially on Low | Wall range limit — not hardware. |

A mapping reset **does not always** restore a reading. If it still will not read, Restart (**Fix G**). Factory Defaults is a last resort: it wipes Wizard geometry (3D looks like a default empty silo until you put Wizard back). Sometimes more than one factory reset is needed. After factory: run this Echo Curve check **before** restoring old false-echo maps.

Overview **SNR** is a scanner **average**. It will not fail one horn.

---


## Which fix (quick)

| Problem | Go to |
|---|---|
| Grey LED, “-” | **Fix A** |
| SNR 0 / Device in Low SNR | **Fix B** |
| Reads full / 20 mA, silo not full | **Fix C**, then **Fix D** if Echo Curve has a near spike |
| Tape farther than software | **Fix D** |
| Wipe maps / start over | **Fix E** then **Fix G** |
| Missing beams / no bottom | **Fix F** |
| Dead after mapping | **Fix G** |
| Mapped but still wrong | **Fix H** |
| Wrong XY / 30° lid | **Fix I** |
| Level lags the process | **Fix J** |
| Confirm what the scanner is using | **Fix K** |
| Auto map keeps coming back | **Fix L** |
| Map hiding the real level | **Fix M** |
| Suspect dead horn / foil / puncture vs false echo | **Fix N** |

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

**Field numbers (type these in the boxes)**

| Site recipe | Where | What to type |
|---|---|---|
| Damping **420** | **Device → Advanced Parameters…** → **Output Damping Time** | **420** → **Upload All** → **Close** (book default is 300; min 60) |
| Fill **7** / empty **8** | Same window → **Max. Filling Rate** / **Max. Emptying Rate** | **7** and **8** for SNR 0 (**Fix B**). If the process is faster, use the real rates (**Fix J**) or the level lags. |
| “MPN 7” on a site sheet | There is no **MPN** box | Use Filling/Emptying **7** / **8** unless a senior tech named a different field |
| Mapping threshold **12000** | **Device False Echo Mapping…** → Action Type **Manual Scan** only | **Threshold** **12000** (book example). On Reset actions the box stays **-** |
| Sleep **Never** | Windows on the **Host** PC | Start → Power → sleep = **Never** (**Fix A** step 5) |

---

## Decision tree (enriched)

Live call order. After each change: **Close** extra windows → **Load from Vessel**.

1. **Grey / no values** → **Fix A**
2. **Device in Low SNR / SNR 0** → clean horns, then **Fix B**. If Echo Curve never has blue above green, stop — software cannot invent an echo.
3. **Reads full / 20 mA / tape much farther** → **Fix K**. Cluster only in first **1.6 ft** → **Fix C**. Spike before the tape → **Fix D**.
4. **Tape ≠ software, SNR OK** → Overview **Distance** (not volume %) → **Fix K**. Avg Distance should match the Echo Curve bottom-axis pick. If both match each other but not volume %, the 3D surface is working; tape is one point. Saved file: **Device → Echo Curve Analyze Viewer…**
5. **False echo** → **Fix D**. Site wipe-all instead → **Fix E**. Wait one damping time. Then **Fix K** again.
6. **Still wrong after mapping** → **Fix H**

---

## Firmware — only the closed bits that change support talk

Full math: `docs/firmware/RESEARCH-CLOSED.md`. For a call, use **Fix K**. Internal formula for a `.bm4` file:

```
dh = 1000 / 65536
G[i] = GradeAmp[i] × 1.01
T[i] = ThresholdAmp[i >> 2]
last_i = last index with G[i] > T[i]
X_m  = last_i × dh
```

**On Echo Curve (same pick the formula describes)**

1. **Device → Echo Curve Analysis…** (or **Echo Curve Analyze Viewer…** for a saved `.bm4`).
2. Units = **ft** or **m** to match the tape.
3. Walk **blue Echo** left (horn) to right (farther). The last place it stays **above green Threshold** is the reported distance — same as Overview **Avg Distance** after **Load from Vessel**.
4. Orange marker (if shown) is that pick.
5. **Red** Auto False Echo and **pink** User False Echo do not change this file. After **Fix D** or **Fix E**, wait one damping time, then run Echo Curve **again**.
6. Left ~**1.64 ft** = dead zone (**Fix C** if that is all you have). Spike before the tape = **Fix D**. Blue never above green = **Fix B** and clean horns.
7. Do not type **1.01** or a Grade×constant into Threshold. Change detection with **Fix M** or **Fix D**.

**Lines on the chart**

| Line | Color | What to do |
|---|---|---|
| Echo | Blue | Reported distance = last stay above green |
| Threshold | Green | Detection floor |
| Auto False Echo | Red | Scanner map. Clear with **Fix E** (or Reset Auto only) |
| User False Echo | Pink | **Fix D** draws this. Reset User / **Fix E** clears it |
| Fuzzy | — | Check **Show Fuzzy** on the toolbar if needed |

**False Echo Mapping**

- **Reset User and Auto** / Reset User / Reset Auto → button **Reset Mapping** (**Fix E**)
- **Scan** — From/To automatic
- **Manual Scan** — From/To + Threshold → **Start Scanning** (**Fix D**)

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

**Enriched:** 7 and 8 are **slower than default 10**. SNR-0 path: **Fix B**. Fast process: **Fix J**. If level lags the process but SNR is healthy, raise the rates — it is not a mapping problem.

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
- Firmware T rewrite uses **× 1.2** in the closed Threshold walk — same family as the sensitivity default.

  **Fix:** **Fix M**. Mapping **Threshold 12000** is only on **Manual Scan** (**Fix D**) — that box is map height, not the 1.2 sensitivity.

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
- *Manual pick: **not fewer than three directional beams**, and they must be **consecutive* (example: 30, 330, and 270).
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

**Enriched — axis points:** **Fix I**. Order **X, Y, Z from center**, **feet**. 30° lid and drawing **10 ft** horizontal: measure **11.5 ft down the slope**, type **11.5**.

---

## Hardware Manual — install problems that look like “software bugs”

### Dead zone / blanking

Hardware p. 10.

- Blanking zone **500 mm**.
- Printed as “500mm (16")” — **16" is wrong**. 500 mm ≈ **19.7 in ≈ 1.64 ft**. Trust the **software** dead band: **0.5 m / 1.64 ft**.

  **Fix:** **Fix C** — wizard **Distance (Top) = 1.64** ft. Echo Curve energy only in the first **~1.6 ft** is dead zone / horn, not a map-to-zero trick.

If material reaches the **antenna**, buildup in the horn → errors or membrane damage.

**Enriched:** torn foil / membrane and powder on a speaker — **Fix N** and **Damaged horn / tin-foil puncture** below.

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

| What you see | Do this |
|---|---|
| Grey / no connection | **Fix A** (COM, poll 00–63, Host sleep Never) |
| SNR 0 / Device in Low SNR | Clean horns, then **Fix B** |
| Frozen old level, then jump | Echo loss hold. After SNR returns, wait; then **Fix K** |
| Reads 100% / 20 mA wrongly | **Fix C**; if Echo Curve spike before tape, **Fix D** |
| Tape ≠ volume % | Overview **Distance** + **Fix K**. Volume % will not match a one-point tape |
| False echoes / too-high level | **Fix D** (To **short of** the tape). Or wipe: **Fix E** |
| After mapping, still wrong | **Fix H** |
| Yellow text on Overview | Wizard settings ≠ vessel (except position / horizontal angle) — re-run wizard **Finish** |
| Red temperature | Outside −40…+85 °C — not a reboot banner. **Fix G** if you need a restart |
| Orange indicator | Configuration warning — check Parameters / wizard |
| Beams missing / odd range | **Fix F** |
| Log empty after reboot | Historic log sampling resets — set it again in Advanced Parameters |
| Demo data / no Low SNR text | Stop Demo, then **Fix B** / **Fix K** on a live Host |
| Center / wall install, “software broken” | **Fix I** / remount (500 mm from wall, not center) |
| One Echo Curve dir grey / empty, others pick | **Fix N** — inspect that horn (foil/membrane, powder, wetness) |

---

## Damaged horn / tin-foil puncture (support)

There is **no** “bad transducer” flag in 3D Vision, firmware, or Capture. The scanner keeps scanning. That face stops returning a usable chirp, so firmware writes **empty Grade** for the beams that needed it.

### Point of failure

The **foil / membrane in the horn** — the acoustic face that keeps water and debris out — not the DSP, not Threshold, not mapping.

Hardware manual: if material reaches the antenna, buildup in the horn causes errors or **membrane damage**. Three horns. Ridge **00** is antenna 1, aimed at vessel center.

Firmware still runs the same chain: ADC → FFT → matched filter against the chirp → magnitude. That magnitude **is Grade**. Pick is **last Grade > Threshold**. No Grade above Threshold → that beam contributes no distance and no mapping hit. Maps cannot create Grade. They only change Threshold / the dashed marker.

**High / Med / Low** fire **all three antennas at once**. One torn horn weakens those three; it does not always grey them out. **Dir 30 … 330** (Med, steered) are the tabs that go empty or grey when a face is dead. Software greys a beam tab when that beam’s Grade is all zeros. Auto Beam Selection can also drop dirs because of silo size — turn Auto off (**Fix N**) before you call hardware.

### Field engineer excerpt — tin foil / water intrusion

Quoted as given (field hardware, not a firmware formula):

> It effects the receiving frequency, not the actual sending frequency. The smoother the reflection is received the better the signal. Just like if there is a medium size piece of material inside the transducer on a single wall. The frequency will then get distributed on the way back to be collected, it wont be collected as it was emitted. Any disruption causing the frequency to "change shapes" is the problem. Ripped foil doesnt have the surface area to receive as it was sent. Also, it acts as a guard to debris inside the transducer. If powder let's say enters into the transducer and lands on one of the speakers, it then is causing a frequency disruption as well as collection because it is interfering with the way the speaker emits the frequency

In short: ripped foil does not collect the return the way it was sent. Foil also keeps powder off the speaker. Powder on a speaker (or material on one wall of a horn) changes the return shape and can change how that speaker emits.

Do **not** write “definitely punctured” on a ticket. List possibles and inspect the horn.

### Damaged beam vs material too close vs false echo

You do not need extra tooling. Echo Curve already tells them apart.

**False echo.** A huge Grade spike toward the material, with a small dashed vertical line on it, is a mapped false echo / near-field junk pick. The beam still has energy. Dragging the dashed line off the spike is mapping work (**Fix D**), not a dead transducer.

**Material too close.** Same family: a massive near-field pile-up, often on several or all nine beams, pick jammed in the first few feet. Mapping hits cluster under the sensor. Energy is there; it is in the wrong place (**Fix C** / clean horns).

**Disrupted receive path (foil / debris / packed wall).** The opposite picture. That one beam’s Grade is empty or flat, its tab greys out, and the other eight still look like real curves. That beam is missing from mapping hits. Do not call that hardware if all nine are weak, or if fill is only on one side of the silo.

### What is not a horn test

| Menu | What it really is |
|---|---|
| Device Activation → **Com Quality** | Wiring / polling. Not horns. |
| Device Activation → **Factory Defaults** | Clears almost everything. You must re-define the silo. **Damping** and **Steepest Material Slope** stay. Not a beam test. |
| **Restart** | New search. Rebuilds **auto** false echoes and damping. Use after mapping trouble, **not** factory, unless factory is actually needed. |
| Debug / “QA” Echo Curve | Loads a `.bm4`. Not a puncture test. |
| Capture **Sensor Recovery** | Factory reset, then writes settings back. No pause to inspect empty-head Grade. |

Run **Fix N** (maps off, all nine beams forced) and read All Beams. Capture Scanner Check can list the same possibles from a `.bm4`; it must not name a puncture.

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
8. Optional later: teach **Fix K** on a saved file — **Device → Echo Curve Analyze Viewer…**, tape vs bottom axis.

---

## Pointers (internal)

- PDF extract: `3D Manuals/Troubleshooting_Manuals.md`
- Firmware closed: `docs/firmware/RESEARCH-CLOSED.md`
- Axis / 30° slope: `docs/engineering-notes-axis-slope.md`
- Horn / foil / maps-off check: this file, **Fix N** and **Damaged horn / tin-foil puncture**
)
