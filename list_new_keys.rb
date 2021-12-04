#!/bin/ruby

require 'json'

this_month_key_file = ARGV[0]
last_month_key_file = ARGV[1]
if this_month_key_file.to_s === "" || last_month_key_file.to_s === ""
  puts "please provide input filename"
  exit(-1)
end

l1 = File.readlines(this_month_key_file).map { |line| line.chomp }
l2 = File.readlines(last_month_key_file).map { |line| line.chomp }

#puts l1.size
#puts l2.size
l3 = l1 - l2
#puts l3.size
l3.each do |line|
  puts line
end
