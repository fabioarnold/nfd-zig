# nfd-zig

`nfd-zig` is a Zig binding to the library [nativefiledialog](https://github.com/mlabbe/nativefiledialog)
which provides a convenient cross-platform interface to opening file dialogs in
Linux, macOS and Windows.

This library has been tested on Windows 10, macOS 11.1 and Linux.

## Usage

You can run the demo with `zig build run`. The demo's source is in `src/demo.zig`.

If you want to add the library to your own project:

- Fetch the `nfdzig` dependency:

```bash
zig fetch --save git+https://github.com/fabioarnold/nfd-zig.git
```

This will add the `nfdzig` dependency to your `build.zig.zon`. e.g.,

```zig
.nfdzig = .{
    .url = "git+https://github.com/fabioarnold/nfd-zig.git#0ad2a0c092ffba0c98613d619b82100c991f5ad6",
    .hash = "nfdzig-0.1.0-11fxvN6IBgD5rvvfjrw1wPqibMsbUJ-h2ZcGR6FOEvrm",
},
```

- Add the module in your `build.zig`:

```zig
const nfdzig = b.dependency("nfdzig", .{ .target = target, .optimize = optimize });
const nfd_mod = nfdzig.module("nfd");
exe.root_module.addImport("nfd", nfd_mod);
```

- Import and use it your code, e.g., `main.zig`:

```zig
const nfd = @import("nfd");

pub fn main() !void {
    const filter = "txt";
    const default_path: ?[]const u8 = null;
    const path: ?[]const u8 = try nfd.openFileDialog(filter, default_path);
}
```

## Screenshot

![Open dialog on Windows 10](https://raw.githubusercontent.com/mlabbe/nativefiledialog/67345b80ebb429ecc2aeda94c478b3bcc5f7888e/screens/open_win.png)
![Open dialog on Linux with GTK 3](https://raw.githubusercontent.com/mlabbe/nativefiledialog/67345b80ebb429ecc2aeda94c478b3bcc5f7888e/screens/open_gtk3.png)
![Open dialog on MacOS with Cocoa](https://raw.githubusercontent.com/mlabbe/nativefiledialog/refs/heads/master/screens/open_cocoa.png)
