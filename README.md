# zig-humantime

This library exports two functions to convert human readable time strings into integer values:

```zig
test "1h2m3s" {
    const time = comptime seconds("1h2m3s");
    // @compileLog(time) -> 7446
    testing.expectEqual(time, 3723);
}

test "2h4m6s" {
    const time = comptime seconds("2h4m6s");
    testing.expectEqual(time, (3600 * 2) + (4 * 60) + 6);
}

test "1h2m3s in milliseconds" {
    const format_string = "1h2m3s";
    const time = milliseconds(format_string);
    // @compileLog(time) -> runtime value
    testing.expectEqual(time, comptime seconds(format_string) * 1000);
}

test "5d4h3m2s" {
    testing.expectEqual(seconds("5d4h3m2s"), 446582);
}
```