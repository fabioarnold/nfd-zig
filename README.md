# nfd-zig

`nfd-zig` is a Zig binding to the library [nativefiledialog](https://github.com/mlabbe/nativefiledialog) which provides a convenient cross-platform interface to opening file dialogs on Linux, macOS and Windows.

This library has been tested on Windows 10, macOS 11.1 and Linux.

## Usage

You can run a demo with `zig build run`. The demo's source is in `src/demo.zig`.

If you want to add the library to your own project...

- Add the `nfd` dependency to your `build.zig.zon`
  ```zig
  .{
    .dependencies = .{
      .nfd = .{ .path = "libs/nfd-zig" }, // Assuming nfd-zig is available in the local directory. Use .url otherwise.
    }
  }
  ```
- Add the import in your `build.zig`:
  ```zig
  const nfd = b.dependency("nfd", .{});
  const nfd_mod = nfd.module("nfd");
  exe.root_module.addImport("nfd", nfd_mod);
  ```

## Screenshot

![Open dialog on Windows 10](https://raw.githubusercontent.com/mlabbe/nativefiledialog/67345b80ebb429ecc2aeda94c478b3bcc5f7888e/screens/open_win.png)
