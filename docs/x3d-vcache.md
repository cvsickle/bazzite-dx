# AMD X3D V-Cache Scheduling

This image includes an optional service, `x3d-cache.service`, that makes the
kernel prefer the V-Cache CCD on dual-CCD AMD X3D processors. It is
**disabled by default**.

## Who needs this

Only systems with a **dual-CCD AMD X3D CPU** (for example Ryzen 9 7900X3D,
7950X3D, 9900X3D, 9950X3D). These chips have one CCD with extra L3 cache
(V-Cache) and one CCD with higher clocks and less cache.

You do **not** need this on Intel CPUs, non-X3D AMD CPUs, or single-CCD X3D
chips (for example 7800X3D, 9800X3D). On those systems the service skips
itself even if you enable it.

## 1. Check that your system supports it

```bash
ls /sys/bus/platform/drivers/amd_x3d_vcache/
```

On a supported system you will see a device entry, usually `AMDI0101:00`:

```bash
AMDI0101:00  bind  module  uevent  unbind
```

If the directory does not exist, this setting does not apply to your system.

Optional: confirm which CCD has the V-Cache. On a 16-core chip, CPU 0 is
on the first CCD and CPU 8 is on the second:

```bash
for c in 0 8; do echo "cpu$c: $(cat /sys/devices/system/cpu/cpu$c/cache/index3/size)"; done
```

The V-Cache CCD reports about `98304K` (96 MB). The other reports about
`32768K` (32 MB).

## 2. Check the current mode

```bash
cat /sys/bus/platform/drivers/amd_x3d_vcache/*/amd_x3d_mode
```

- `frequency`: the scheduler prefers the high-clock CCD (default)
- `cache`: the scheduler prefers the V-Cache CCD

The setting lives at
`/sys/bus/platform/drivers/amd_x3d_vcache/<device>/amd_x3d_mode`, where
`<device>` is the entry from step 1. This is a virtual file that the kernel
creates at boot. Changes to it last only until reboot, which is why the
service exists.

## 3. Try it temporarily (optional)

Test before you make it permanent. This lasts until you reboot:

```bash
echo cache | sudo tee /sys/bus/platform/drivers/amd_x3d_vcache/*/amd_x3d_mode
```

Relaunch the game and compare performance in the same area.

## 4. Enable it permanently

```bash
sudo systemctl enable --now x3d-cache.service
```

This sets the mode right away and again on every boot. The setting stays
in place through image updates.

Verify:

```bash
systemctl status x3d-cache.service
cat /sys/bus/platform/drivers/amd_x3d_vcache/*/amd_x3d_mode   # should print: cache
```

## Undo

```bash
sudo systemctl disable x3d-cache.service
echo frequency | sudo tee /sys/bus/platform/drivers/amd_x3d_vcache/*/amd_x3d_mode
```

## Notes

- `cache` mode is a scheduler preference for the whole system, not only
  games. Other programs can still use the frequency CCD when needed.
- To check where a game is actually running, use MangoHud with
  `MANGOHUD_CONFIG=core_load,cpu_stats,gpu_stats,fps` and look at which
  cores are busy.
- If you prefer to affect just one game, skip the service and add a CPU
  pin to that game's Steam launch options, for example
  `taskset -c 0-7,16-23 %command%` on a 7950X3D. Use `lscpu -e` to find the
  right CPU numbers for your chip.
  