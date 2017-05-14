class Board
	attr_accessor :grid, :knight
	def initialize
		@grid = default_grid
		@knight = Knight.new(@grid)
	end

	private

	def default_grid
		arr = []
		y = 7
		while y >= 0
			x = 0
			while x <= 7
				arr << Square.new([x, y])
				x += 1
			end
			y -= 1
			x = 0
		end
		return arr
	end
end

class Knight
	attr_accessor :grid, :paths
	def initialize(grid)
		@grid = grid
		@paths = knight_graph(grid)
	end

	def knight_moves(from, to)	#([0, 7], [1, 5])
		queue, visited = [from], [] #[[0, 7]]
		parent_relations = {}
		until queue.empty?
			cur = queue.shift
			cur_index = @grid.index { |sq| sq.val == cur } #Grabs index of cur square in @grid
			if cur == to 
				shortest_path = trace_shortest_path(cur_index, parent_relations)
				puts "You made it in #{shortest_path.length} moves! Here is your path:"
				shortest_path.each { |move| puts move.inspect }
				break
			end
			@paths[cur_index].each do |path|
				unless visited.include?(path)
					queue << @grid[path].val 
					parent_relations[path] = cur_index
				end
			end
			visited << cur_index
		end
	end

	private

	def trace_shortest_path(cur_index, parent_relations)
		arr = []
		until cur_index.nil?
			arr.unshift(@grid[cur_index].val)
			cur_index = parent_relations[cur_index]	
		end
		return arr
	end

	# Method that treats all of the board's squares as verticies of a graph
	# so we can know all of the squares a knight can jump to from a specific square.
	def knight_graph(grid)
		map = {} 
		grid.each_with_index do |sq, i|
			map[i] = []
			x, y = sq.val[0], sq.val[1]
			potential_paths = [[x + 1, y + 2], [x + 2, y + 1], [x + 2, y - 1],
					 		 					 [x + 1, y - 2], [x - 1, y - 2], [x - 2, y - 1],
					     					 [x - 2, y + 1], [x - 1, y + 2]]
			potential_paths.each do |path|
				# Ensures we don't choose a path that goes off of the board
				if (path[0] >= 0 && path[0] <= 7) && (path[1] >= 0 && path[1] <= 7)
					map[i].push(neighbor_index(grid, path))
				end
			end
		end
		return map
	end

	def neighbor_index(grid, path)
		grid.index { |sq| sq.val == path }
	end

end

class Square
	attr_accessor :val
	def initialize(value)
		@val = value
	end
end

board = Board.new
board.knight.knight_moves([0, 7], [3, 4])