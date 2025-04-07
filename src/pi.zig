const std = @import("std");
const c = @cImport({
    @cInclude("math.h");
});

var factorials: ?*std.ArrayList(f128) = null;

fn factorial(n: f128) std.mem.Allocator.Error!f128 {
    if (factorials == null) {
        return 0;
    }

    if (@as(f128, @floatFromInt(factorials.?.items.len)) >= n) {
        return factorials.?.items[@intFromFloat(n)];
    }

    for ((factorials.?.items.len - 1)..@intFromFloat(n)) |i| {
        try factorials.?.append(factorials.?.items[i] * @as(f128, @floatFromInt((i + 1))));
    }

    return factorials.?.items[@intFromFloat(n)];
}

fn inversePI(k: i64) std.mem.Allocator.Error!f128 {
    const fk128: f128 = @floatFromInt(k);
    const ckl: c_longdouble = @floatFromInt(k);
    const k1factorial = try factorial(fk128);
    const k3factorial = try factorial(3.0 * fk128);
    const k6factorial = try factorial(6.0 * fk128);
    return (12.0 * c.powl(-1.0, ckl) * k6factorial * (13591409.0 + 545140134.0 * fk128)) /
        (k3factorial * c.powl(@floatCast(k1factorial), 3.0) * c.powl(640320.0, 3.0 * ckl + 1.5));
}
pub fn main() !void {
    comptime var k: i64 = 0;
    inline while (k < 5) : (k += 1) {
        const result = try inversePI(k);
        std.debug.print("inverse pi[k={}]={}\n", .{ k, result });
    }
}
