#!/usr/bin/ruby

require 'json'

input_filename = ARGV[0]
if input_filename.to_s === ""
  puts "please provide input filename"
  exit(-1)
end

PENSION_PAYMENT_RATE = 0.09

File.readlines(input_filename).each do |line|
  splits = line.strip.split(",")
  n = splits.length
  yyyymm = splits[0]
  company_name = splits[1]
  registration_num = splits[2]
  registered = splits[3] == 1
  postal_code = splits[4]
  address = splits[5]
  street_address = splits[6]
  industry_name= splits[n-8]
  total_employee_count = splits[n-4].to_i
  national_pension_paid_total = splits[n-3].to_i
  new_employee_count = splits[n-2].to_i
  quit_employee_count = splits[n-1].to_i
  national_pension_paid_per_employee = total_employee_count > 0 ? (national_pension_paid_total / total_employee_count) : 0
  avg_monthly_salary = (national_pension_paid_per_employee / PENSION_PAYMENT_RATE).to_i
  h = { yyyymm: yyyymm, companyName: company_name, registrationNum: registration_num,
        industryName: industry_name,
        registered: registered, postalCode: postal_code, address: address,
        streetAddress: street_address, totalEmployeeCount: total_employee_count,
        newEmployeeCount: new_employee_count, quitEmployeeCount: quit_employee_count,
        nationalPensionPaidTotal: national_pension_paid_total,
        nationalPensionPaidPerEmployee: national_pension_paid_per_employee,
        avgMonthlySalary: avg_monthly_salary }
  puts h.to_json
end
