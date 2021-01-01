# nfd-zig

`nfd-zig` is a Zig binding to the library [nativefiledialog](https://github.com/mlabbe/nativefiledialog), that provides a convenient cross-platform interface to opening file dialogs on Linux, macOS and Windows.

For now this library has been tested only on Windows 10 and macOS 11.1.

## Usage

Before building on macOS you need to set an environment variable: `export ZIG_SYSTEM_LINKER_HACK=1`
You can run a demo with `zig build run`. The source is in `src/demo.zig`.

If you want to add the library to your own project

* Add the `nfd` package to your executable in your ```build.zig```
  ```zig
  exe.addPackage(std.build.Pkg{
      .name = "nfd",
      .path = "deps/nfd-zig/src/lib.zig",
  });
  ```

* Because `nativefiledialog` is a C library you have to link it to your executable
  ```zig
  const nfd_build = @import("deps/nfd-zig/build.zig");
  const nfd_lib = try nfd_build.makeLib(b, mode, target, "deps/nfd-zig/");
  exe.linkLibrary(nfd_lib);
  ```


## Screenshot

![Open dialog on Windows 10](https://raw.githubusercontent.com/mlabbe/nativefiledialog/67345b80ebb429ecc2aeda94c478b3bcc5f7888e/screens/open_win.png)
