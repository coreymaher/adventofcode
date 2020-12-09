import sys

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

groups = []
with open(sys.argv[1], "r") as f:
    groups = f.read()[:-1].split("\n\n")

total = 0
for group in groups:
    questions = {}
    for person in group.split("\n"):
        for answer in person:
            questions[answer] = True

    total += len(questions.keys())


print(f"Total: {total}")
