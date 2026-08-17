# BM4 grades file format

Decoded from decompiled:

- `ApplMngr/TDLM/ApplMngr/BeamDataParser.cs`
- `Parser/TDLM/Parser/HartParserNew.cs` (`ConvertFract32ToSingle`, `ConvertIEEE754ToSingle`, …)

Validated against **format example**  
`assets/grades/example-format-only.bm4`  
(original name `2_2025-08-22 10-23-29.bm4` — **not** a quality reference).

---

## File header (16 bytes)

| Offset | Type | Meaning |
|--------|------|---------|
| 0 | u32/i32 | Field read by parser (example: `0x0004FBD0`) — not used further in `ParseBeamFile` |
| 4 | i32 | `numSeries` — number of 32-byte series headers |
| 8 | i32 | `NumOfBeams` (example: **9**) |
| 12 | i32 | `beamStride` — byte stride between beams for a given series (example: **23804**) |

## Series header (32 bytes × numSeries)

| Offset | Type | Meaning |
|--------|------|---------|
| 0 | i32 | `Offset_from_fileStart` — sample data start for beam 0 |
| 4 | i32 | `length` — sample count (int16 samples) |
| 8–18 | char[11] | `representation_tag` (NUL-padded), e.g. `Grade`, `Threshold`, `AFE`, `False E.` |
| 20 | fract32 | `representation_offset` → meters |
| 24 | fract32 | `representation_resulotion` → meters/sample |
| 28 | i32 | `Offset_to_Gain` — IEEE754 float gain for beam 0 |

### Fract32 → meters

```text
ConvertFract32ToSingle(x) = (x / 2^31) * 1000
```

### Sample index → distance

```text
h = representation_offset + i * representation_resulotion
```

### Sample → amplitude

```text
raw = uint16 at (Offset_from_fileStart + beamIndex * beamStride + i * 2)
amp = ArrayToFract(raw) * gain
gain = IEEE754 float at (Offset_to_Gain + beamIndex * beamStride)
```

`ArrayToFract` (BeamDataParser):

```text
if raw > 32768:  (65536 - raw) / 32768
else:            raw / 32768
```

## Series tags (firmware string table + this example)

| Tag | UI legend name (ViewBeamSingle) | Color |
|-----|----------------------------------|-------|
| `Grade` | Echo | Blue |
| `Threshold` | Threshold | `#00FF00` |
| `AFE` | Auto False Echo | Red |
| `False E.` | User False Echo | Magenta |
| `Grades E` | (debug / tag as-is) | Brown |
| `Theta` | (debug) | LightGreen |
| `Phi` | (debug) | Yellow |

PC charting caps headers at **6** (`if numSeries > 6: numSeries = 6`).  
In the example file: 7 headers present; **Phi** is stored but not charted by PC.

## Per-beam measured distance (Orange line)

For series index 0 (`Grade`), immediately before sample data:

```text
measured_m = ConvertFract32ToSingle( int32 at dataOff - 4 )
→ BeamLine(Orange, measured_m)
```

Example file: Orange ≈ **12.197 m** on all beams (`MaxHValue`).

## Example file facts (format only)

| Item | Value |
|------|-------|
| Size | 216072 bytes |
| Beams | 9 (all `beamsHasData = true`) |
| Grade samples | 5242 @ Δh ≈ 0.01526 m → span ~80 m |
| Threshold samples | 1310 @ Δh ≈ 0.0610 m |
| AFE samples | 655 @ Δh ≈ 0.122 m |
| False E. samples | 327 @ Δh ≈ 0.244 m |

Gains and amplitudes are **device-scaled** (often large). UI SciChart may format the Y axis; do not assume 0..1 from this file alone.

## What this does *not* define

- How the scanner chooses Grade / Threshold / AFE sample values  
- What a “good” vs “bad” echo looks like  
- How to synthesize new curves for arbitrary vessels  

Those require firmware (LDR) reverse engineering — see `docs/firmware/LDR-RE.md`.
