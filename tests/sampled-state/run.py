#!/usr/bin/env python3
"""Run the production sampled-state collector on owned children only."""
from datetime import datetime
from pathlib import Path
import os
import subprocess

root = Path(__file__).resolve().parents[2]
work = root / ".work" / ("sampled-state-" + datetime.now().strftime("%Y%m%dT%H%M%S%f"))
work.mkdir()
(work / "tmp").mkdir()
env = dict(os.environ, TMPDIR=str(work / "tmp"),
           ZIG_LOCAL_CACHE_DIR=str(work / "cache"),
           ZIG_GLOBAL_CACHE_DIR=str(work / "global"))
bindings = {}
for name, header in (("c_live", "tests/sampled-state/c_live.h"),
                     ("c_profile_linux_perf", "src/bindings/profile_linux_perf.h"),
                     ("c_profile_runtime", "src/bindings/profile_runtime.h"),
                     ("c_profile_runtime_1", "src/bindings/profile_runtime_1.h")):
    dest = work / (name + ".zig")
    dest.write_bytes(subprocess.check_output(["zig", "translate-c", "-lc", "-I", "src/runtime", header],
                                             cwd=root, env=env, timeout=120))
    bindings[name] = dest
command = ["zig", "test", "-O", "ReleaseSafe", "--dep", "perf", "--dep", "c_live",
           "-Mroot=tests/sampled-state/live.zig",
           "-I", "src/runtime", *[str(p) for p in sorted(Path("src/runtime").glob("*.c")) if p.name != "agent_main.c"], "src/profile/allocation_broker.c",
           "--dep", "c_profile_linux_perf", "--dep", "c_profile_runtime", "--dep", "c_profile_runtime_1",
           "-Mperf=src/profile/linux_perf.zig",
           *["-M" + name + "=" + str(path) for name, path in bindings.items()], "-lc"]
with (work / "live.log").open("x") as log:
    result = subprocess.run(command, cwd=root, env=env, stdout=log,
                            stderr=subprocess.STDOUT, timeout=180)
print(work)
print((work / "live.log").read_text())
raise SystemExit(result.returncode)
