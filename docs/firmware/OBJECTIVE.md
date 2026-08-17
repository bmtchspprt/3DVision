# Objective

Echo Curve must **simulate a Grades window**, not a gaussian cartoon.

## Ship

1. **Grade** — pulse compression: LFM chirp, delayed reflections (material + extras), matched filter, magnitude, divide by peak (emit scale). Axis `h(i)=i×(1000/65536)` m.
2. **Threshold** — documented walk: windowed `rsqrt(G)`, `÷4`, AFE neighbor mix, `÷2`, `×1.2`, floor `0.25`.
3. **AFE** — `AFE[i>>3]=max(AFE, Grade[i])`. No mix (`a` unused).
4. **User False E.** — opcode 6 From/To/Threshold series. Pick does **not** read it.
5. **Orange** — last `Grade×1.01 > T[i>>2]`.
6. **Chart X** — vessel height (what you look at), not 80 m of empty axis.

## Advanced parameters (what they actually do here)

| Field | In this sim |
|---|---|
| Damping | Not applied to Orange |
| MinimalSnr / CRAF | Not a Grade compare |
| Maps | Drawn; do not skip this pick. AFE feeds Threshold mix |

## Stimulus (not ADC DMA)

Reflections at distances we know (vessel empty-to-product, optional map window). That is the input to the firmware processing chain. Bit-identical Blackfin FFT/BFP is not required; emit scale makes the displayed envelope match `amp ≈ grade_f/scale`.
