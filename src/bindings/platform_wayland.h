/* C declarations translated by build_c.zig. */
#undef _FORTIFY_SOURCE // as in c_ui.zig
#define _GNU_SOURCE 1
#define VK_USE_PLATFORM_WAYLAND_KHR 1
#include "unistd.h"
#include "stdlib.h"
#include "errno.h"
#include "poll.h"
#include "time.h"
#include "wayland-client.h"
#include "../platform/clipboard.h"
#include "xdg-shell-client-protocol.h"
#include "xdg-decoration-unstable-v1-client-protocol.h"
#include "cursor-shape-v1-client-protocol.h"
#include "linux-dmabuf-v1-client-protocol.h"
#include "fractional-scale-v1-client-protocol.h"
#include "viewporter-client-protocol.h"
#include "presentation-time-client-protocol.h"
#include "vulkan/vulkan.h"
