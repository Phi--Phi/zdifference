const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "pi",
        .root_source_file = b.path("src/pi.zig"),
        .target = b.graph.host,
        .link_libc = true,
    });

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
