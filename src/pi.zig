const std = @import("std");

fn inversePI(k: i64) f128 {
    return 12 * (std.math.pow(i64, -1, k) * std.math.gamma(i64, 6 * k - 1) * (13591409 + 545140134 * k)) / (std.math.gamma(i64, 3 * k - 1) * std.math.pow(i128, std.math.gamma(i64, k - 1), 3) * std.math.pow(f64, 640320, 3 * @as(f64, k) + 1.5));
}
pub fn main() void {
    comptime var k: i64 = 0;
    inline while (k < 5) : (k += 1) {
        const result = inversePI(k);
        std.debug.print("inverse pi[k={}]={}\n", .{ k, result });
    }
}
