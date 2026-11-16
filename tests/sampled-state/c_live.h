#undef _FORTIFY_SOURCE
#define _GNU_SOURCE 1
#include "unistd.h"
#include "fcntl.h"
#include "signal.h"
#include "sys/wait.h"
#include "time.h"
#include "dirent.h"
#include "linux/perf_event.h"
#include "asm/perf_regs.h"
