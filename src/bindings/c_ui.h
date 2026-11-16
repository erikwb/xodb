/* C declarations translated by build_c.zig. */
#undef _FORTIFY_SOURCE // glibc's fortified fcntl wrappers do not translate; ReleaseSafe defines it
#define _GNU_SOURCE 1
#include "unistd.h"
#include "stdlib.h"
#include "stdio.h"
#include "string.h"
#include "fcntl.h"
#include "errno.h"
#include "signal.h"
#include "poll.h"
#include "dirent.h"
#include "time.h"
#include "sys/stat.h"
#include "../runtime/xrt_sysstat.h"
#include "../runtime/xrt_fdactivity.h"
#include "../runtime/xrt_fdflow_graph.h"
#include "../runtime/xrt_fdinherit.h"
#include "../runtime/xrt_fdtreemap.h"
#include "../runtime/xrt_memobserver.h"
#include "../text.h"
#if XODB_GUI
#include "vulkan/vulkan.h"
#include "freetype/freetype.h"
#include "hb.h"
#include "hb-ft.h"
#endif
