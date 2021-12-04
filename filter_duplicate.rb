#!/bin/ruby

dup_filename = ARGV[0]

file = File.open(dup_filename)
duplicates = file.readlines.map(&:chomp)
file.close

input_filename = ARGV[1]
file = File.open(input_filename)

file.readlines.each do |line|
  line = line.chomp
  splits = line.split(",")
  company_name = splits[1]
  company_reg_num = splits[2]
  postal_code = splits[4]
  industry_code = splits[13]
  registered_date = splits[15]
  key = "#{company_name},#{registered_date},#{company_reg_num},#{postal_code}"
  if duplicates.include?(key)
    next
  end
  puts line
end


