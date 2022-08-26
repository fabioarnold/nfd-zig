# nfd-zig

`nfd-zig` is a Zig binding to the library [nativefiledialog](https://github.com/mlabbe/nativefiledialog) which provides a convenient cross-platform interface to opening file dialogs on Linux, macOS and Windows.

This library has been tested on Windows 10, macOS 11.1 and Linux.

## Usage

You can run a demo with `zig build run`. The demo's source is in `src/demo.zig`.

If you want to add the library to your own project...

- Add the `nfd` package to your executable in your `build.zig`
  ```zig
  const nfd_build = @import("deps/nfd-zig/build.zig");
  exe.addPackage(nfd_build.getPackage("nfd"));
  ```
- Because `nativefiledialog` is a C library you have to link it to your executable
  ```zig
  const nfd_build = @import("deps/nfd-zig/build.zig");
  const nfd_lib = nfd_build.makeLib(b, mode, target);
  exe.linkLibrary(nfd_lib);
  ```

## Screenshot

![Open dialog on Windows 10](https://raw.githubusercontent.com/mlabbe/nativefiledialog/67345b80ebb429ecc2aeda94c478b3bcc5f7888e/screens/open_win.png)
