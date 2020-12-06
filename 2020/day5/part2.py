import sys

if len(sys.argv) != 2:
    print(f"{sys.argv[0]} <FILENAME>")
    exit(1)

with open(sys.argv[1], "r") as f:
    passes = [line[:-1] for line in f]


def get_position(value, min, max, minLetter, maxLetter):
    for pos in value[:-1]:
        amount = round((max - min) / 2)
        if pos == minLetter:
            max -= amount
        elif pos == maxLetter:
            min += amount

    return min if value[-1] == minLetter else max


missing_seat_id = 0
min_id = 999999
max_id = 0
seats = {}
for board_pass in passes:
    row = get_position(board_pass[0:7], 0, 127, "F", "B")
    column = get_position(board_pass[7:], 0, 7, "L", "R")

    value = (row * 8) + column
    if value > max_id:
        max_id = value
    if value < min_id:
        min_id = value
    seats[value] = True

for seat_id in range(min_id, max_id):
    if seat_id not in seats and (seat_id - 1) in seats and (seat_id + 1) in seats:
        missing_seat_id = seat_id

print(f"Missing Seat ID: {missing_seat_id}")
