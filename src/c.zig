//! C seen by the debug engine. Rendering, platform and UI code use c_ui.zig.
pub const api = if (@import("builtin").os.tag == .macos) @import("c_macos.zig").api else @import("c_c");
