require_relative 'helper'

module Aggregate
	def caculate_prob(combination, records, dictionary)
		prob = 1

		records.each_with_index do |record, index|
			if combination.include? index
				prob *= record.bdd.exist_prob(dictionary)
			else
				prob *= record.bdd.non_exist_prob(dictionary)
			end
		end

		prob
	end

	def COUNT(records, dictionary)
		prob = Array.new(records.length + 1, 0)

		indexs = (0..records.length - 1).to_a

		(0..records.length).each do |i|
			indexs.combination(i).each do |combination|
				prob[i] += caculate_prob(combination, records, dictionary)
			end
		end

		return (0..records.length).to_a, prob
	end

	def count_prob(number_of_records=20)
		dictionary = Helper.prepare_dictionary
		records = Helper.prepare_record(number_of_records)
		number, prob = COUNT(records, dictionary)

		arr = []

		number.zip(prob).each do |n, p|
			arr.append({ count: n, prob: p })
		end
		Helper.print_result(arr)
	end
end

include Aggregate

count_prob(ENV['RECORDS'].to_i)
