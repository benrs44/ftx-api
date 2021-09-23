class Array

	def symbolize_keys
		map(&:symbolize_keys)
	end
	
end