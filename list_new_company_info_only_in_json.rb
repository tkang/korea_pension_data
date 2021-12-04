#!/bin/ruby

require 'json'

new_key_file = ARGV[0]
monthly_data_csv_file = ARGV[1]
if new_key_file.to_s === "" || monthly_data_csv_file.to_s === ""
  puts "please provide input filename"
  exit(-1)
end

PENSION_PAYMENT_RATE = 0.09

new_keys = File.readlines(new_key_file).map { |line| line.chomp }

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
  total_employee_count = splits[n-4].to_i
  national_pension_paid_total = splits[n-3].to_i
  new_employee_count = splits[n-2].to_i
  quit_employee_count = splits[n-1].to_i
  national_pension_paid_per_employee = total_employee_count > 0 ? (national_pension_paid_total / total_employee_count) : 0
  avg_monthly_salary = (national_pension_paid_per_employee / PENSION_PAYMENT_RATE).to_i
  key = "#{company_name}##{registered_date}##{registration_num}##{postal_code}"
  next unless new_keys.include?(key)
  #h = { id: key, yyyymm: yyyymm, companyName: company_name, registrationNum: registration_num,
  #      industryCode: industry_code, industryName: industry_name, registeredDate: registered_date,
  #      registered: registered, postalCode: postal_code, address: address,
  #      streetAddress: street_address, totalEmployeeCount: total_employee_count,
  #      newEmployeeCount: new_employee_count, quitEmployeeCount: quit_employee_count,
  #      nationalPensionPaidTotal: national_pension_paid_total,
  #      nationalPensionPaidPerEmployee: national_pension_paid_per_employee,
  #      avgMonthlySalary: avg_monthly_salary }
  h = { companyName: company_name, id: key, searchableName: company_name, weight: 0,
        registrationNum: registration_num,
        industryCode: industry_code, industryName: industry_name, registeredDate: registered_date,
        registered: registered, postalCode: postal_code, address: address,
        streetAddress: street_address }
  puts h.to_json
end
