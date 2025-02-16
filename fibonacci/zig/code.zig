const std = @import("std");

const fibonacci = @import("./fibonacci.zig").fibonacci;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args_cli = try std.process.argsAlloc(allocator);

    if (args_cli.len < 2) {
        const stderr = std.io.getStdErr().writer();
        try stderr.writeAll("Please provide a number as argument.\n");
        std.process.exit(1);
    }

    const args = args_cli[1..];

    const runs = try std.fmt.parseInt(usize, args[0], 0);

    var sum: usize = 0;

    for (0..runs) |i| {
        sum += fibonacci(i);
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{d}\n", .{sum});
}
