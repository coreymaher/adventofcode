import sys
import re

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

valid = 0
with open(sys.argv[1], "r") as f:
    for line in f:
        match = re.match(
            r"^(?P<min>\d+)-(?P<max>\d+) (?P<letter>\w): (?P<password>\w+)$", line
        )
        captures = match.groupdict()

        matches = 0
        for letter in captures["password"]:
            if captures["letter"] == letter:
                matches += 1

        if int(captures["min"]) <= matches <= int(captures["max"]):
            valid += 1

print(f"Valid Passwords: {valid}")
