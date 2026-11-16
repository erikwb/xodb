//! Build-time validation of the same catalogs published by the application.
const std = @import("std");
const catalog = @import("tool_catalog.zig");

pub fn main() void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var failure: ?catalog.Failure = null;
    catalog.validateInputs(arena.allocator(), &failure) catch |err| {
        std.debug.print("MCP catalog {s}: {s}\n", .{ if (failure) |f| f.catalog else "validation", @errorName(err) });
        std.process.exit(1);
    };
}
