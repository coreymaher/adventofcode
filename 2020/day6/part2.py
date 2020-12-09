import sys
from collections import defaultdict

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

groups = []
with open(sys.argv[1], "r") as f:
    groups = f.read()[:-1].split("\n\n")

total = 0
for group in groups:
    questions = defaultdict(int)
    people = group.split("\n")
    for person in people:
        for answer in person:
            questions[answer] += 1

    for answers in questions.values():
        if answers == len(people):
            total += 1


print(f"Total: {total}")
