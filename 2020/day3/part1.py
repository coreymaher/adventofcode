import sys

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

with open(sys.argv[1], "r") as f:
    x = 0
    trees = 0
    for line in f:
        if line[x] == "#":
            trees += 1
        x = (x + 3) % (len(line) - 1)

print(f"Trees Encountered: {trees}")
