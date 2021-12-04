#!/bin/ruby

require 'json'

monthly_data_csv_file = ARGV[0]
if monthly_data_csv_file.to_s === ""
  puts "please provide input filename"
  exit(-1)
end

File.readlines(monthly_data_csv_file).each_with_index do |line, idx|
  next if idx === 0
  splits = line.strip.split(",")
  n = splits.length
  yyyymm = splits[0]
  company_name = splits[1]
  registration_num = splits[2]
  registered = splits[3].to_i
  postal_code = splits[4]
  address = splits[5]
  street_address = splits[6]
  industry_code = splits[13]
  industry_name= splits[14]
  registered_date = splits[15]
  key = "#{company_name}##{registered_date}##{registration_num}##{postal_code}"
  puts key
end
