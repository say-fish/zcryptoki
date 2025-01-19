const std = @import("std");
const Build = std.Build;
const builtin = @import("builtin");

// https://github.com/latchset/pkcs11-headers
pub const Version = enum {
    @"2.40",
    @"3.0",
    @"3.1",
};

pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const version = b.option(
        Version,
        "version",
        "cryptoki API version",
    ) orelse .@"3.1";
    const deprecated = b.option(
        bool,
        "deprecated",
        "enable deprecated functions",
    ) orelse false;

    const zcryptoki = b.addModule(
        "zcryptoki",
        .{
            .root_source_file = b.path("src/zcryptoki.zig"),
            .target = target,
            .optimize = optimize,
        },
    );

    switch (version) {
        inline else => |v| zcryptoki.addIncludePath(b.path("include/" ++ @tagName(v))),
    }

    if (deprecated) zcryptoki.addCMacro("PKCS11_DEPRECATED", "");
}
