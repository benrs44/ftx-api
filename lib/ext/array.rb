class Array

	def symbolize_keys
		map(&:symbolize_keys)
	end

	def compact_blank
		delete_if {|i| i.respond_to?(:empty?) ? !!i.empty? : !i }
	end
	
end