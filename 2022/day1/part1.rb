data = File.read("input")
elves = data.split(/\n{2}/)

max = 0
elves.each do |elf|
	inventory = elf.split(/\n/)
	total = inventory.sum(&:to_i)
	max = total if total > max
end

puts "Max: #{max}"
