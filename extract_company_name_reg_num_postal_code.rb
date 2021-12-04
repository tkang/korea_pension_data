#!/bin/ruby
#
#2021-04,평안운수(주),210810,1,01332,서울특별시 도봉구 방학동,서울특별시 도봉구 마들로,1132010600,1132069000,11,320,106,1,602204,시내버스 운송업 / 시외버스 운송업,1988-01-01,0001-01-01,0001-01-01,4,1521000,0,0

filename = ARGV[0]

#line = "2021-04,평안운수(주),210810,1,01332,서울특별시 도봉구 방학동,서울특별시 도봉구 마들로,1132010600,1132069000,11,320,106,1,602204,시내버스 운송업 / 시외버스 운송업,1988-01-01,0001-01-01,0001-01-01,4,1521000,0,0"
#splits = line.split(",")
#company_name = splits[1]
#company_address = splits[5]
#puts "#{company_name},#{company_address}"
#puts filename

file = File.open(filename)

file.readlines.each do |line|
  line = line.chomp
  splits = line.split(",")
  company_name = splits[1]
  company_reg_num = splits[2]
  postal_code = splits[4]
  address = splits[5]
  street_address = splits[6]
  industry_code = splits[13]
  registered_date = splits[15]
  key = "#{company_name},#{registered_date},#{company_reg_num},#{postal_code}"
  puts key
end

