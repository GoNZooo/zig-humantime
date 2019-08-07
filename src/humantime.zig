const std = @import("std");
const testing = std.testing;
const fmt = std.fmt;

pub fn seconds(human_string: []const u8) u64 {
    return humanStringToInt(human_string, 1);
}

pub fn milliseconds(human_string: []const u8) u64 {
    return humanStringToInt(human_string, 1000);
}

fn humanStringToInt(human_string: []const u8, multiplier: u32) u32 {
    var current_number: u32 = 0;
    var total_time: u32 = 0;

    for (human_string) |s| {
        switch (s) {
            '0' => current_number *= 10,
            '1'...'9' => {
                // pre-requisite already checked in the switch, fatal error if we error out on this
                const digit = fmt.charToDigit(s, 10) catch unreachable;
                current_number *= 10;
                current_number += digit;
            },
            's' => {
                total_time += multiplier * current_number;
                current_number = 0;
            },
            'm' => {
                total_time += 60 * multiplier * current_number;
                current_number = 0;
            },
            'h' => {
                total_time += 3600 * multiplier * current_number;
                current_number = 0;
            },
            else => continue,
        }
    }

    return total_time;
}

test "1h2m3s" {
    const time = comptime seconds("1h2m3s");
    testing.expectEqual(time, 3723);
}

test "2h4m6s" {
    const time = comptime seconds("2h4m6s");
    testing.expectEqual(time, (3600 * 2) + (4 * 60) + 6);
}

test "1h2m3s in milliseconds" {
    const format_string = "1h2m3s";
    const time = comptime milliseconds(format_string);
    testing.expectEqual(time, comptime seconds(format_string) * 1000);
}

test "2h4m6s in milliseconds" {
    const format_string = "2h4m6s";
    const time = comptime milliseconds(format_string);
    testing.expectEqual(time, comptime seconds(format_string) * 1000);
}

test "2h4m6s in milliseconds at runtime" {
    const format_string = "2h4m6s";
    const time = milliseconds(format_string);
    testing.expectEqual(time, seconds(format_string) * 1000);
}

test "2h" {
    testing.expectEqual(comptime seconds("2h"), 7200);
}

test "2m5s" {
    testing.expectEqual(comptime seconds("2m5s"), 125);
}

test "2h5s" {
    testing.expectEqual(comptime seconds("2h5s"), 7205);
}
