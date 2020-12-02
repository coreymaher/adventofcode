import sys
import re

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

valid = 0
with open(sys.argv[1], "r") as f:
    for line in f:
        match = re.match(
            r"^(?P<idx1>\d+)-(?P<idx2>\d+) (?P<letter>\w): (?P<password>\w+)$", line
        )
        captures = match.groupdict()

        matches = 0
        if captures["password"][int(captures["idx1"]) - 1] == captures["letter"]:
            matches += 1
        if captures["password"][int(captures["idx2"]) - 1] == captures["letter"]:
            matches += 1

        if matches == 1:
            valid += 1

print(f"Valid Passwords: {valid}")
