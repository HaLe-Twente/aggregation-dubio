class Dictionaries
	attr_accessor :dicts

	def initialize(dict_str)
		@dicts = []
		add_to_dict(dict_str)
	end

	def add(dict_str)
		add_to_dict(dict_str)
	end

	private

	def add_to_dict(dict_str)
		dict_arr = dict_str.split(';')

		dict_arr.each do |dict|
			el = {}
			rv, prob = dict.strip.split(':')
			el[rv] = prob.to_f
			@dicts.append(el)
		end
	end
end
