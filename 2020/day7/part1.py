import sys
import re

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

bags = {}
with open(sys.argv[1], "r") as f:
    for line in f:
        match = re.match(r"^(.+?) bags", line)
        color = match.group(1)

        inner_bags = re.findall(r"(\d+) (.+?) bag", line)
        bags[color] = []
        for bag in inner_bags:
            bags[color].append(bag[1])

bag_cache = {}
target_bag = "shiny gold"


def contains_target_bag(color):
    if color in bag_cache:
        return bag_cache[color]

    if not bags[color]:
        bag_cache[color] = False
        return False

    if target_bag in bags[color]:
        bag_cache[color] = True
        return True

    bag_cache[color] = any(contains_target_bag(bag) for bag in bags[color])

    return bag_cache[color]


for bag_color in bags.keys():
    contains_target_bag(bag_color)

result = len([color for color, contains in bag_cache.items() if contains])
print(f"Result: {result}")
