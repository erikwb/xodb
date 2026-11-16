/* C declarations translated by build_c.zig. */
#undef _FORTIFY_SOURCE
#define _GNU_SOURCE 1
#define BIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD 1 // translate-c needs one ioctl declaration
#include "unistd.h"
#include "fcntl.h"
#include "errno.h"
#include "poll.h"
#include "signal.h"
#ifndef __APPLE__
#include "spawn.h"
#endif // Darwin Mach types stay in macos_process.c.
#include "sys/socket.h"
#include "sys/wait.h"
#include "arpa/inet.h"
#include "netinet/tcp.h"
#include "time.h"
