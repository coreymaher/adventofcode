import sys

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

with open(sys.argv[1], "r") as f:
    lines = [line[:-1] for line in f]


def check_slope(dx, dy):
    x = 0
    y = 0
    trees = 0

    while y < len(lines):
        if lines[y][x] == "#":
            trees += 1

        x = (x + dx) % len(lines[y])
        y += dy

    return trees


result = 1
for slope in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]:
    result *= check_slope(slope[0], slope[1])
print(f"Result: {result}")
