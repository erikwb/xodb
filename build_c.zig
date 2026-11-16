//! Translate each C interface once, preserving type identity across consumers.
const std = @import("std");

pub fn add(b: *std.Build, module: *std.Build.Module, gui: bool, platform: []const u8) void {
    const macos = module.resolved_target.?.result.os.tag == .macos;
    const bindings = [_]struct { name: []const u8, enabled: bool }{
        .{ .name = "c", .enabled = !macos },
        .{ .name = "c_macos", .enabled = macos },
        .{ .name = "c_ui", .enabled = true },
        .{ .name = "capture_live", .enabled = !macos },
        .{ .name = "frames_c", .enabled = true },
        .{ .name = "mcp_server", .enabled = !macos },
        .{ .name = "memdefrag_tui", .enabled = !macos },
        .{ .name = "model_compatibility", .enabled = !macos },
        .{ .name = "model_kernel_census", .enabled = !macos },
        .{ .name = "model_modules", .enabled = !macos },
        .{ .name = "model_pe_images_1", .enabled = !macos },
        .{ .name = "observe_archive", .enabled = !macos },
        .{ .name = "observe_linux", .enabled = !macos },
        .{ .name = "platform_cocoa", .enabled = macos },
        .{ .name = "platform_wayland", .enabled = gui and (std.mem.eql(u8, platform, "wayland") or std.mem.eql(u8, platform, "linux")) },
        .{ .name = "platform_x11", .enabled = gui and (std.mem.eql(u8, platform, "x11") or std.mem.eql(u8, platform, "linux")) },
        .{ .name = "platform_xkb", .enabled = gui and !macos },
        .{ .name = "profile_allocation_live", .enabled = !macos },
        .{ .name = "profile_archive", .enabled = !macos },
        .{ .name = "profile_linux_allocations", .enabled = !macos },
        .{ .name = "profile_linux_perf", .enabled = !macos },
        .{ .name = "profile_runtime", .enabled = !macos },
        .{ .name = "profile_runtime_1", .enabled = !macos },
        .{ .name = "redot_protocol", .enabled = !macos },
        .{ .name = "remote_transport", .enabled = true },
        .{ .name = "semq_ghidra_sidecar", .enabled = !macos },
        .{ .name = "semq_host", .enabled = !macos },
        .{ .name = "service_lease", .enabled = true },
        .{ .name = "target_runtime", .enabled = true },
        .{ .name = "target_runtime_test", .enabled = !macos },
        .{ .name = "ui_overview_actions", .enabled = !macos },
    };
    for (bindings) |binding| {
        if (!binding.enabled) continue;
        const translation = b.addTranslateC(.{
            .root_source_file = b.path(b.fmt("src/bindings/{s}.h", .{binding.name})),
            .target = module.resolved_target.?,
            .optimize = module.optimize.?,
        });
        translation.defineCMacro("XODB_GUI", if (gui) "1" else "0");
        // Include generated protocol headers and private dependency prefixes,
        // with the same pkg-config flags as the consuming module.
        for (module.include_dirs.items) |include| switch (include) {
            .path => |path| translation.addIncludePath(path),
            .path_system => |path| translation.addSystemIncludePath(path),
            .path_after => |path| translation.addAfterIncludePath(path),
            .framework_path => |path| translation.addFrameworkPath(path),
            .framework_path_system => |path| translation.addSystemFrameworkPath(path),
            .config_header_step => |header| translation.addConfigHeader(header),
            else => @panic("unsupported C binding include path"),
        };
        for (module.link_objects.items) |object| switch (object) {
            .system_lib => |lib| translation.linkSystemLibrary(lib.name, .{
                .needed = lib.needed,
                .weak = lib.weak,
                .use_pkg_config = lib.use_pkg_config,
                .preferred_link_mode = lib.preferred_link_mode,
                .search_strategy = lib.search_strategy,
            }),
            else => {},
        };
        module.addImport(b.fmt("c_{s}", .{binding.name}), translation.createModule());
    }
}
