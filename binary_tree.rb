class Node 
	attr_accessor :val, :parent, :left, :right

	def initialize(val, parent = nil, left = nil, right = nil)
		@val = val
		@parent = parent
		@left = left
		@right = right
	end
end

class BinaryTree
	attr_accessor :root

	def initialize(root = nil)
		@root = root
	end

	def build_tree(arr)
		arr.each do |el|
			if @root.nil?
				@root = Node.new(el)
			else
				insert_node(el, @root)
			end
		end
	end

	def breadth_first(target)
		queue = [@root]
		cur = queue.first
		until queue.empty?
			return cur if cur.val == target
			queue.concat(children(cur)).shift
			cur = queue.first
		end
		return nil
	end

	def depth_first(tar) #In-Order Traversal
		stack, visited = [@root], []
		cur = stack.last
		until stack.empty?
			if cur.left.nil? || visited.include?(cur.left)
				return cur if cur.val == tar
				r_child = cur.right
				visited << cur
				stack.pop
				stack << r_child unless r_child.nil?
			else
				stack << cur.left
			end
			cur = stack.last
		end
		return nil
	end

	def dfs_rec(tar, cur = @root)
		return cur if cur.val == tar
		left_child = dfs_rec(tar, cur.left) unless cur.left.nil?
		right_child = dfs_rec(tar, cur.right) unless cur.right.nil?
		return left_child || right_child
	end

	private

	def insert_node(data, node)
		if data < node.val
			if node.left.nil?
				node.left = Node.new(data, node)
			else
				insert_node(data, node.left)
			end
		elsif data > node.val
			if node.right.nil?
				node.right = Node.new(data, node)
			else
				insert_node(data, node.right)
			end
		end
	end

	def children(node)
		arr = []
		arr.push(node.left) unless node.left.nil?
		arr.push(node.right) unless node.right.nil?
		return arr
	end
end










