data = File.read("input")
elves = data.split(/\n{2}/)

inventories = elves.map do |elf|
	elf.split(/\n/).sum(&:to_i)
end

total = inventories.sort.last(3).sum

puts "Total: #{total}"
