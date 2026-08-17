# Objective

Echo Curve must look like a real Grades `.bm4`: a **filled range-gated envelope**, then zeros — not needles.

## Firmware (unchanged)

- `h(i)=i×(1000/65536)` m
- Pick: last `Grade×1.01 > T[i>>2]`
- AFE max at `i>>3`; user map is stored; pick does not read maps

## Shape (from a known-good recording)

~1100 nonzero Grade samples, a **several-meter** main lobe, Threshold high near 0 m, Grade breaking through in the lobe. The guide builds that envelope for the vessel; it does not paste the file.
