class Array

	def symbolize_keys
		map(&:symbolize_keys)
	end

	def compact_empty
		delete_if {|i| i.respond_to?(:empty?) ? !!i.empty? : !i }
	end
	
end