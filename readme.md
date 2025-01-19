# zcryptoki

FOSS version of [pkcs11](https://docs.oasis-open.org/pkcs11/pkcs11-spec/v3.1/pkcs11-spec-v3.1.html) headers packaged for the zig build system.

## Usage

1. Fetch:

```bash
zig fetch --save git+https://github.com/say-fish/zcryptoki
```

2. Add it to your build system:

```zig
const zcryptoki = b.dependency("zcryptoki", .{
    .target = target,
    .optimize = optimize,
    .version = .@"3.1", // pkcs11 version: optional, defaults to 3.1
    .deprecated = false,  // where to enable deprecated features, defaults to false
});
```

3. Use it:

```zig
const cki = @import("zcryptoki");
cki.CK_OBJECT_HANDLE
...
```
