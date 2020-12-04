import sys
import re

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

with open(sys.argv[1], "r") as f:
    passports = f.read().split("\n\n")

required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
valid = 0
for data in passports:
    passport = {}
    for item in re.split(r"\s+", data):
        if item:
            key, value = item.split(":")
            passport[key] = value

    if all([key in passport for key in required]):
        valid += 1


print(f"Valid: {valid}")
