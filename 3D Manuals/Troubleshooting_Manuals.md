# Troubleshooting from the 3D manuals

Use this file instead of re-reading the PDFs in this folder.

**Sources (this folder)**

| File | What it is | Dated / notes |
|---|---|---|
| `Software Manual.pdf` | 3DVision / 3DMultiVision operating instructions | © 2013 BinMaster, 73 pages. No troubleshooting chapter. |
| `Hardware Manual.pdf` | 3DLevelScanner operating / install | © 2023 BinMaster, 42 pages. No troubleshooting chapter. |
| `Multi-point Measurement Refresher.pdf` | Sales / “how 3D works” | 8 pages. Not a service document. |

Page numbers below are **PDF page numbers** as printed in the software book (contents are 1 behind the PDF page in a few places; citations use the printed footer when it matters).

---

## How this relates to the install-guide troubleshooting list

The current guide topics are **field procedures plus UI walkthroughs**. The manuals describe **how the software and scanner work**. There is no 1:1 troubleshooting chapter to copy.

| Guide topic | Manual logic | Verdict |
|---|---|---|
| SNR Reading is 0 | Below Minimal SNR the scanner **does not measure**; damping **improves SNR**. Fill/empty rates should match the **process**. Mapping is a **separate** Grades-driven step. | **Partly.** 420 / MPN 7 / fill 7 / empty 8 are **not** in the manuals. |
| Sensor full / Distance (Top) 1.64 | Wizard full calibration default **0.5 m (1.64 ft)**; dead band 50 cm from the horn. | **Yes** (software book). |
| Wizard dead-zone | Same as above. Material inside dead band → bad / locked reading. | **Yes.** |
| Reset after mapping clear | Device Activations: **Reset (Restart)** rebuilds auto false echoes and damping (~30 s). Do **not** use factory reset. | **Yes** for Restart vs Factory. Temperature alert and “~20 mA” are **not** reboot proofs in the book. |
| Controller sleep | Not in these manuals. | **Field / PC only.** |
| Auto Beam Selection | Default **automatic**. Uncheck Auto Beam Selection to pick beams. At least **three consecutive** directional beams. Automatic Beams Range is a **separate** default-on control. | **Partly.** Guide “all 6 checked” skips the consecutive-3 rule. |
| How to read Echo Curve | Software tool is **Grades Analysis**, not Echo Curve. X = distance from scanner; Y = echo energy (no unit). Compare to tape/laser. | **Different tool name / workflow.** The idea (near spikes = false echo) matches Grades. |
| Reset Sensor Mapping | Action **Reset All False Echoes** / **Reset Mapping** wipes auto + user maps. Published **fix** for false echoes is **Manual Scan** after Grades, not a wipe. | **Reset exists.** Book’s recommended path is Manual Scan. |
| Advanced Parameters review | Upload All, Close discards un-uploaded changes. Auto False Echo default **Enable**. Disable **stops ongoing auto maps** and keeps the last image. | **Partly.** “Always deactivate Auto False Echoes” is not a generic manual rule. |

**Numbers that are field practice, not manual values**

- Output Damping Time **420** (manual default **300 s**, minimum **60 s**)
- Max Filling Rate **7** / Max Emptying Rate **8** (manual default **10**; “set to actual process”)
- **MPN Rate** (not named in these manuals)
- False-echo **threshold 12000** appears only as an **example** in the Grades + mapping walkthrough
- Windows sleep = **Never**

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

### Server vs client

- Install **Server** on the Host / controller PC. Do **not** install Server on remote PCs (slow).
- Remote PCs: **Client only**.
- One license code per Server.
- Firewall / router: open the TCP ports the installer documents (software p. 12 area) for LAN client-to-server.
- **Show Server Last Error** (Tools) retrieves the last error from the server.

### Toolbar / Device menu (names the walkthroughs should use)

- **Load from Vessel** — download measurements from all scanners on the selected vessel (updates Overview).
- **Load from Vessels** — all vessels.
- **Connect / Disconnect** vessel or scanner.
- **Device → Advanced Parameters…** (F3)
- **Device → Device False Echo Mapping…**
- **Device → Grades Analysis…** / **Grades Analysis Viewer…**
- **Device → Device Activation…** (reset options)
- Close on Advanced Parameters **discards** changes that were not uploaded.

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

SNR **0** / low SNR is a **measurement** condition (Minimal SNR). The 2013 book does not list the Overview string “Device in Low SNR”; it does define Minimal SNR behavior (below).

### SNR and echo loss

Software p. 45–47.

- **Minimal SNR** default **13 dB**. Below this, the sensor **does not measure** and the **reading stays unchanged**. Setting Minimal SNR **below 10 dB is not recommended**.
- **Output Damping Time** — history window; **increases stability and improves SNR**. Default **300 s**, minimum **60 s**. Increase for large MVL systems with **more than 2 scanners**.
- **Exceeding Filling Rate After Echo Loss** (default Yes): when SNR is below Minimal SNR, the algorithm **assumes filling**; when SNR returns it may **exceed** the filling-rate limit to catch up to the real level.

**If SNR is 0 / stuck:** treat as echo loss (Minimal SNR). Manual levers: damping (higher), process fill/empty rates, then **Grades + mapping** if false echoes. There is **no** published “type 420 / 7 / 8” recipe.

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

### Filling / emptying rates and capacity

- **Max Capacity** default 100 (mass).
- **Max Emptying Rate** / **Max Filling Rate** default **10** (mass/hour).
- Set these to the **actual process**. Too low → algorithm cannot follow real fill/empty. Too high → noisier / less stable tracking.

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

### Beams

Software p. 47–48.

- **Auto Beam Selection** on by default. Algorithm may drop beams from silo size.
- Uncheck Auto Beam Selection to choose manually.
- **High / Med / Low** — three frequencies, all three antennas at once.
- **Dir 30, 90, 150, 210, 270, 330** — six directionals, same frequency as Med.
- Manual pick: **not fewer than three directional beams**, and they must be **consecutive** (example: 30, 330, and 270).
- **Automatic Beams Range** on by default: range limited where the beam hits the wall. Low frequency = wider = more limited. High frequency = narrow = little limit. Algorithm keeps at least one beam that can see the bottom.

### Device Activations (reset)

Software p. 59. `Device → Device Activation…`

| Option | What it does | Does **not** reset |
|---|---|---|
| **Reset (Restart) Device** | Restart DSP. Rebuilds **auto false echoes** and **damping**. ~**30 s**. New search for the correct measurement. | — |
| **Reset to Factory Defaults** | Most parameters to factory. Must re-define almost everything. | **Output Damping Time**, **Steepest Material Slope** |
| **Reset Advanced Parameters and False Echoes** | All advanced parameters (and maps, per title). | Damping, steepest slope, Max Capacity, Max Emptying Rate, Max Filling Rate. **Wizard geometry stays.** |

Pick device(s) in the tree, choose the option, press **Reset**.

Hardware onboard menu (Hardware p. 31) is similar: **Reset** = power-up / clear measurements; **Reset to Factory** = all defaults + reset; **Reset to Lab** = factory password, do not use in the field.

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

### Output (4–20 mA) vs displayed volume

Software p. 49–55.

- Output type: Volume (default), Mass, Level, or Distance.
- **20 mA = 100%** of whatever that type is (full calibration for level/volume).
- **4 mA = 0% / empty.**
- After mapping or wizard changes: **Upload All**; if something is invalid, an alert names the problem.
- Book recommends **3DLevelManager** (not 3DVision) for current simulation and firmware upgrade; close Server and Client first.

A **20 mA** reading after reset only means “output at full,” not “reboot succeeded.”

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

### Demo mode

Software p. 63.

- Fast / Normal / Slow run.
- **Must be stopped** before returning to live operation.
- **Exiting the app does not stop demo.**

### Multi-scanner / geometry

- Device positions: X/Y from vessel **center**.
- Bottom center can be offset from the body center.
- Wizard Finish uploads to **all scanners in the vessel**.

---

## Hardware Manual — install problems that look like “software bugs”

### Dead zone / blanking

Hardware p. 10.

- Blanking zone **500 mm**.
- Printed as “500mm (16")” — **16" is wrong**. 500 mm ≈ **19.7 in ≈ 1.64 ft**. Trust the **software** dead band: **0.5 m / 1.64 ft**.

If material reaches the **antenna**, buildup in the horn → errors or membrane damage.

Measurements are to the **top of the body**. Neck extension / head-body split: adjust all distances to that reference.

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

### Moisture, wiring, noise

- Cable downward before the gland so water drains.
- Tighten glands; 8–13 mm / 20 AWG typical.
- Screened twisted pair if EMI is expected.
- Ground the chassis.
- Supply **24 VDC**, about **1.5 W**, at the scanner.
- Motors / noisy gear nearby can hurt performance.

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

---

## Symptom cheat sheet (manual logic only)

| What you see | First checks from the books |
|---|---|
| Grey / no connection | COM, poll 00–63 unique, RS-485 120 Ω cable, converter, not Server-on-remote-PC, firewall, HART = one device per COM, 4-wire power not on signal terminals |
| SNR 0 or stuck reading | Minimal SNR 13 dB; damping; fill/empty vs process; horn buildup / material in dead zone; then Grades |
| Reads 100% / 20 mA wrongly | Distance (Top) / full calibration ≥ **1.64 ft**; Top Dead Band Don’t Discard presents full cal when closer; material in horn |
| False echoes / too-high level | Tape vs Grades; Manual Scan From/To; wait **one damping time**; do not map the real surface |
| After mapping, still wrong | Wait damping time; Restart (not Factory) rebuilds auto maps; Load from Vessel |
| Yellow text on Overview | Scanner wizard settings ≠ vessel (except position / horizontal angle) |
| Red temperature | Process/ambient outside −40…+85 °C — not a reboot banner |
| Orange indicator | Configuration warning |
| Beams missing / odd range | Auto Beam Selection; Automatic Beams Range (orange line on Grades); ≥3 consecutive dirs if manual |
| Log empty after reboot | Historic log sampling resets to “don’t store” |
| Demo data / won’t go live | Stop Demo Mode explicitly |

---

## Install-guide follow-ups (if we ever align TS to the books)

1. Echo / mapping topics should walk **Grades Analysis → tape compare → Manual Scan From/To → Start Scanning → wait one damping time**, not “Echo Curve” as the software name.
2. SNR 0 should not present **420 / 7 / 8 / MPN** as factory numbers; damping↑ and process rates are what the book states.
3. Reset User and Auto False Echoes is a **wipe**, not the 7.5.1 mapping example.
4. Auto beams: document **three consecutive** directionals; Automatic Beams Range is separate.
5. After Restart: ~30 s init, then Load from Vessel — **not** “wait for temperature alert” or “expect 20 mA.”
6. Dead zone: keep **1.64 ft**; ignore hardware “16".”
)
