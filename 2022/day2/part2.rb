score = 0

class Move
	attr_reader :defeats, :loses, :points

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

class Strategy
	def initialize(name)
		@name = name
	end

	def perform(move); end
end

class LoseStrategy < Strategy
	def initialize()
		super("lose")
	end

	def perform(opponent_move)
		[ROCK, PAPER, SCISSORS].find { |move| move.loses == opponent_move }.score(opponent_move)
	end
end

class WinStrategy < Strategy
	def initialize()
		super("win")
	end

	def perform(opponent_move)
		[ROCK, PAPER, SCISSORS].find { |move| move.defeats == opponent_move }.score(opponent_move)
	end
end

class DrawStrategy < Strategy
	def initialize()
		super("draw")
	end

	def perform(opponent_move)
		[ROCK, PAPER, SCISSORS].find { |move| move.defeats != opponent_move && move.loses != opponent_move }.score(opponent_move)
	end
end

moves = {
	"A": OPPONENT_ROCK,
	"B": OPPONENT_PAPER,
	"C": OPPONENT_SCISSORS,
}

strategies = {
	"X": LoseStrategy.new,
	"Y": DrawStrategy.new,
	"Z": WinStrategy.new,
}

File.open('input').each do |line|
	opponent_input, strategy_input = line.chomp.split(' ')
	opponent_move = moves[opponent_input.to_sym]
	strategy = strategies[strategy_input.to_sym]

	score += strategy.perform(opponent_move)
end

puts "Score: #{score}"
