//! Private-state access used only for deliberate test fault injection.
comptime {
    if (!@import("builtin").is_test) @compileError("test-only runtime access");
}
pub const c = @import("c_target_runtime_test");
