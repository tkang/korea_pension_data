#!/bin/ruby

require 'aws-sdk-dynamodb'
require 'json'

# Adds an item to a table in Amazon DynamoDB.
#
# @param dynamodb_client [Aws::DynamoDB::Client] An initialized
#   Amazon DynamoDB client.
# @param table_item [Hash] The properties of the item, in the correct format.
# @example
#   add_item_to_table(
#     Aws::DynamoDB::Client.new(region, 'us-west-2'),
#     {
#       table_name: 'Movies',
#       item: {
#         "year": 1985,
#         "title": "The Big Movie",
#         "info": {
#           "directors": ["Mary"],
#           "release_date": "1985-12-25T00:00:00Z",
#           "rating": 5.5,
#           "genres": [
#             "Action",
#             "Drama"
#           ],
#           "image_url": "http://docs.aws.amazon.com/assets/images/aws_logo_dark.png",
#           "plot": "Nothing happens at all.",
#           "rank": 2,
#           "running_time_secs": 7380,
#           "actors": [
#             "Larry",
#             "Moe",
#             "Curly"
#           ]
#         }
#       }
#     }
#   )
def add_item_to_table(dynamodb_client, table_item)
  dynamodb_client.put_item(table_item)
  puts "Added company: #{table_item[:item]['companyName']} " \
    "(#{table_item[:item]['yyyymm']})"
rescue StandardError => e
  puts 'Error adding company ' \
    "#{table_item[:item]['company_name']} " \
    "(#{table_item[:item]['yyyymm']})': #{e.message}"
  puts 'Program stopped.'
  exit 1
end

REGION = 'ap-northeast-2'
TABLE_NAME = 'Company-lbswzt43dvdtdjg23afuavrr3q-dev'
#DATA_FILE = 'KoreaNationalPensionData_202104_UTF8.json'
DATA_FILE = 'sample.json'

# Full example call:
def run_me
  region = REGION
  table_name = TABLE_NAME
  data_file = DATA_FILE
  dynamodb_client = Aws::DynamoDB::Client.new(region: region)

  puts "Adding companies from file '#{data_file}' " \
    "into table '#{table_name}'"

  header_lines = 1
  batch_size = 1000

  File.open(data_file) do |file|
    file.lazy.drop(header_lines).each_slice(batch_size) do |lines|
      lines.each do |line|
        company = JSON.parse(line)
        table_item = {
          table_name: table_name,
          item: company
        }
        puts table_item
        add_item_to_table(dynamodb_client, table_item)
      end
    end
  end

  puts 'Done.'
end

run_me if $PROGRAM_NAME == __FILE__
