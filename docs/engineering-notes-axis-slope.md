# Engineering notes — axis points & 30° slope

Source: BinMaster tech. Reference for future install-guide tips — **not** implemented as emulator logic.

## Axis points (Wizard → Dimensions)

| Order | Meaning |
|-------|---------|
| 1st | X from center |
| 2nd | Y from center |
| 3rd | Z from center |

In the software: open **Wizard** → silo **dimensions** → click **Next** → axis points appear. Units are **feet**.

## 30° slope (center sensor)

When measuring along a 30° slope from center, use cosine(30°) ≈ **0.866**:

```
slope distance (ft) = horizontal distance from center (ft) ÷ 0.866
```

Example: 10 ft from center horizontally → `10 ÷ 0.866 ≈ 11.54` → measure **~11.5 ft down the slope**.
