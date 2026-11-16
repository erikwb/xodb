//! C seen by rendering, platform and UI code, and by the system collectors
//! whose snapshots the UI draws. Nothing here is the debug engine's: no ptrace,
//! ELF, DWARF or kernel headers (those are c.zig). A header that declares types lives in only one of the
//! two, so its types are the same everywhere.
pub const api = @import("c_c_ui");
