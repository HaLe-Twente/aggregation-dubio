require_relative 'helper'

module Aggregate
    def caculate_prob(combination, records, dictionary)
        prob = 1

        records.each_with_index do |record, index|
            if combination.include? index
                prob *= record.bdd.prob(dictionary)
            else
                prob *= 1 - record.bdd.prob(dictionary)
            end
        end

        prob
    end

    def COUNT(records, dictionary)
        prob = Array.new(records.length + 1, 0)

        record_indexs = (0..records.length - 1).to_a

        total_combination = 0

        (0..records.length).each do |i|
            number_of_combination = 0

            record_indexs.combination(i).each do |combination|
                prob[i] += caculate_prob(combination, records, dictionary)
                number_of_combination += 1
            end

            puts "Number of combination for #{i} records: #{number_of_combination}"
            total_combination += number_of_combination
        end

        puts "Total combination: #{total_combination}"

        return (0..records.length).to_a, prob
    end

    def perform(number_of_records=20)
        dictionary = Helper.prepare_dictionary
        records = Helper.prepare_record(number_of_records)

        number_of_records, prob = COUNT(records, dictionary)

        Helper.print_result(number_of_records, prob)
    end
end

include Aggregate

perform(ENV['RECORDS'].to_i)
