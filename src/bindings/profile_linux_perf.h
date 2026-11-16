/* C declarations translated by build_c.zig. */
#undef _FORTIFY_SOURCE // glibc fortified fcntl wrappers cannot be translated in ReleaseSafe
#define _GNU_SOURCE 1
#define BIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD 1 // translate-c needs one ioctl declaration
#include "errno.h"
#include "fcntl.h"
#include "stdio.h"
#include "unistd.h"
#include "string.h"
#include "sys/ioctl.h"
#include "sys/mman.h"
#include "sys/syscall.h"
#include "linux/perf_event.h"
#include "time.h"
