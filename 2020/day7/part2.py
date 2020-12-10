import sys
import re

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

bags = {}
result = 0
target_bag = "shiny gold"
with open(sys.argv[1], "r") as f:
    for line in f:
        match = re.match(r"^(.+?) bags", line)
        color = match.group(1)

        inner_bags = re.findall(r"(\d+) (.+?) bag", line)
        bags[color] = []
        for bag in inner_bags:
            bags[color].append(bag)


def number_of_inner_bags(color):
    bag = bags[color]

    result = 0
    for inner_bag in bag:
        result += int(inner_bag[0]) * (number_of_inner_bags(inner_bag[1]) + 1)

    return result


res = number_of_inner_bags(target_bag)
print(f"Result: {res}")
