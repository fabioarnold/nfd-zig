const std = @import("std");
const builtin = std.builtin;
const Builder = std.build.Builder;

pub fn makeLib(b: *Builder, mode: builtin.Mode, target: std.zig.CrossTarget, comptime prefix: []const u8) *std.build.LibExeObjStep {
    const lib = b.addStaticLibrary("nfd", prefix ++ "src/lib.zig");
    lib.setBuildMode(mode);
    lib.setTarget(target);

    const cflags = [_][]const u8{
        "-Wall",
    };
    lib.addIncludeDir(prefix ++ "nativefiledialog/src/include");
    lib.addCSourceFile(prefix ++ "nativefiledialog/src/nfd_common.c", &cflags);
    if (lib.target.isDarwin()) {
        lib.addCSourceFile(prefix ++ "nativefiledialog/src/nfd_cocoa.m", &cflags);
    } else if (lib.target.isWindows()) {
        lib.addCSourceFile(prefix ++ "nativefiledialog/src/nfd_win.cpp", &cflags);
    } else {
        lib.addCSourceFile(prefix ++ "nativefiledialog/src/nfd_gtk.c", &cflags);
    }

    lib.linkLibC();
    if (lib.target.isDarwin()) {
        lib.linkFramework("AppKit");
    } else if (lib.target.isWindows()) {
        lib.linkSystemLibrary("shell32");
        lib.linkSystemLibrary("ole32");
        lib.linkSystemLibrary("uuid"); // needed by MinGW
    } else {
        lib.linkSystemLibrary("gdk-3");
        lib.linkSystemLibrary("gtk-3");
        lib.linkSystemLibrary("glib-2.0");
        lib.linkSystemLibrary("gobject-2.0");
    }

    return lib;
}

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});
    const lib = makeLib(b, mode, target, "");
    lib.install();

    var demo = b.addExecutable("demo", "src/demo.zig");
    demo.setBuildMode(mode);
    demo.addPackage(std.build.Pkg{
        .name = "nfd",
        .path = "src/lib.zig",
    });
    demo.linkLibrary(lib);
    demo.install();

    const run_demo_cmd = demo.run();
    run_demo_cmd.step.dependOn(b.getInstallStep());

    const run_demo_step = b.step("run", "Run the demo");
    run_demo_step.dependOn(&run_demo_cmd.step);
}
