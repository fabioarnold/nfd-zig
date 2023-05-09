const std = @import("std");

pub fn build(b: *std.Build) !void {
    var target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const nfd = b.addModule("nfd", .{ .source_file = .{ .path = "src/lib.zig" } });

    const lib = b.addStaticLibrary(.{
        .name = "nfd",
        .root_source_file = .{ .path = "src/lib.zig" },
        .target = target,
        .optimize = optimize,
    });
    lib.setMainPkgPath(".");
    lib.addModule("nfd", nfd);

    const cflags = [_][]const u8{"-Wall"};
    lib.addIncludePath("nativefiledialog/src/include");
    lib.addCSourceFile("nativefiledialog/src/nfd_common.c", &cflags);
    if (lib.target.isDarwin()) {
        lib.addCSourceFile("nativefiledialog/src/nfd_cocoa.m", &cflags);
    } else if (lib.target.isWindows()) {
        lib.addCSourceFile("nativefiledialog/src/nfd_win.cpp", &cflags);
    } else {
        lib.addCSourceFile("nativefiledialog/src/nfd_gtk.c", &cflags);
    }

    lib.linkLibC();
    if (lib.target.isDarwin()) {
        lib.linkFramework("AppKit");
    } else if (lib.target.isWindows()) {
        lib.linkSystemLibrary("shell32");
        lib.linkSystemLibrary("ole32");
        lib.linkSystemLibrary("uuid"); // needed by MinGW
    } else {
        lib.linkSystemLibrary("atk-1.0");
        lib.linkSystemLibrary("gdk-3");
        lib.linkSystemLibrary("gtk-3");
        lib.linkSystemLibrary("glib-2.0");
        lib.linkSystemLibrary("gobject-2.0");
    }
    lib.installHeadersDirectory("nativefiledialog/src/include", ".");
    b.installArtifact(lib);

    var demo = b.addExecutable(.{
        .name = "nfd-demo",
        .root_source_file = .{ .path = "src/demo.zig" },
        .target = target,
        .optimize = optimize,
    });
    demo.addIncludePath("nativefiledialog/src/include");
    demo.addModule("nfd", nfd);
    demo.linkLibrary(lib);
    b.installArtifact(demo);

    const run_demo_cmd = b.addRunArtifact(demo);
    run_demo_cmd.step.dependOn(b.getInstallStep());

    const run_demo_step = b.step("run", "Run the demo");
    run_demo_step.dependOn(&run_demo_cmd.step);
}
