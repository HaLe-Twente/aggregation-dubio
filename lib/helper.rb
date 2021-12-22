require_relative 'dictionary'
require_relative 'record'
require_relative 'bdd'

class Helper
	def self.prepare_dictionary
		dict_str = 'd1=1:0.8;d1=2:0.2; d2=1:0.7;d2=2:0.3; d3=1:0.5;d3=2:0.5'
		Dictionaries.new(dict_str).dicts
	end

	def self.prepare_record(number_of_records=20)
		# FIXME: generate multiple records
		record_1 = Record.new(1, Bdd.new('d1=1'))

		[record_1] * number_of_records
	end

	def self.write_header(columns)
	  puts "| #{ columns.map { |_,g| g[:label].to_s.ljust(g[:width]) }.join(' | ') } |"
	end

	def self.write_divider(columns)
	  puts "+-#{ columns.map { |_,g| "-"*g[:width] }.join("-+-") }-+"
	end

	def self.write_line(h, columns)
	  str = h.keys.map { |k| h[k].to_s.ljust(columns[k][:width]) }.join(" | ")
	  puts "| #{str} |"
	end

	def self.print_result(arr)
		col_labels = { count: "COUNT", prob: "Prob" }
		columns = col_labels.each_with_object({}) do |(col,label),h|
			h[col] = { label: label,
		             	width: [arr.map { |g| g[col].to_s.size }.max, label.to_s.size].max }
		end

		self.write_divider(columns)
		self.write_header(columns)
		self.write_divider(columns)
		arr.each { |h| write_line(h, columns) }
		write_divider(columns)
	end
end

