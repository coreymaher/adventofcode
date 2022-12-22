score = 0

class Move
	def initialize(name, defeats: nil, loses: nil, points: nil)
		@name = name
		@defeats = defeats
		@loses = loses
		@points = points
	end

	def score(move)
		outcome = if move == @defeats
			6
		elsif move == @loses
			0
		else
			3
		end

		outcome + @points
	end
end

OPPONENT_ROCK = Move.new("rock")
OPPONENT_PAPER = Move.new("paper")
OPPONENT_SCISSORS = Move.new("scissors")

ROCK = Move.new("rock", defeats: OPPONENT_SCISSORS, loses: OPPONENT_PAPER, points: 1)
PAPER = Move.new("paper", defeats: OPPONENT_ROCK, loses: OPPONENT_SCISSORS, points: 2)
SCISSORS = Move.new("scissors", defeats: OPPONENT_PAPER, loses: OPPONENT_ROCK, points: 3)

moves = {
	"A": OPPONENT_ROCK,
	"B": OPPONENT_PAPER,
	"C": OPPONENT_SCISSORS,

	"X": ROCK,
	"Y": PAPER,
	"Z": SCISSORS,
}

File.open('input').each do |line|
	opponent_move, self_move = line.chomp.split(' ').map { |input| moves[input.to_sym] }
	score += self_move.score(opponent_move)
end

puts "Score: #{score}"
