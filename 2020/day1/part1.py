import sys

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

EXPECTED_SUM = 2020

with open(sys.argv[1], "r") as f:
    lines = [int(line) for line in f]


def find():
    for i in range(0, len(lines)):
        first = lines[i]
        for j in range(i + 1, len(lines)):
            second = lines[j]
            if first + second == EXPECTED_SUM:
                return first * second


result = find()
print(f"Result: {result}")
