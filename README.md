# zig-humantime

This library exports two functions to convert human readable time strings into integer values:

```zig
test "1h2m3s" {
    const time = comptime seconds("1h2m3s"); // @typeName(@typeOf(time)) == "comptime_int"
    testing.expectEqual(time, 3723);
}

test "2h4m6s" {
    const time = comptime seconds("2h4m6s"); // @typeName(@typeOf(time)) == "comptime_int"
    testing.expectEqual(time, (3600 * 2) + (4 * 60) + 6);
}
```