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

    if not all([key in passport for key in required]):
        continue
    if int(passport["byr"]) < 1920 or int(passport["byr"]) > 2002:
        continue
    if int(passport["iyr"]) < 2010 or int(passport["iyr"]) > 2020:
        continue
    if int(passport["eyr"]) < 2020 or int(passport["eyr"]) > 2030:
        continue
    if not any([unit in passport["hgt"] for unit in ["cm", "in"]]):
        continue
    if "cm" in passport["hgt"]:
        height = int(passport["hgt"].replace("cm", ""))
        if height < 150 or height > 193:
            continue
    if "in" in passport["hgt"]:
        height = int(passport["hgt"].replace("in", ""))
        if height < 59 or height > 76:
            continue
    if not re.match(r"^\#[0-9a-f]{6}$", passport["hcl"]):
        continue
    if passport["ecl"] not in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
        continue
    if not re.match(r"^\d{9}$", passport["pid"]):
        continue

    valid += 1


print(f"Valid: {valid}")
