#!/bin/ruby

require 'json'

input_filename = ARGV[0]
if input_filename.to_s === ""
  puts "please provide input filename"
  exit(-1)
end

PENSION_PAYMENT_RATE = 0.09

File.readlines(input_filename).each_with_index do |line, idx|
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
  h = { companyInfoId: key, yyyymm: yyyymm,
        totalEmployeeCount: total_employee_count,
        newEmployeeCount: new_employee_count, quitEmployeeCount: quit_employee_count,
        nationalPensionPaidTotal: national_pension_paid_total,
        nationalPensionPaidPerEmployee: national_pension_paid_per_employee,
        avgMonthlySalary: avg_monthly_salary }
  #h = { companyName: company_name, id: key,
  #      registrationNum: registration_num,
  #      industryCode: industry_code, industryName: industry_name, registeredDate: registered_date,
  #      registered: registered, postalCode: postal_code, address: address,
  #      streetAddress: street_address }
  puts h.to_json
end
