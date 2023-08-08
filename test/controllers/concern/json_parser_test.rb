require 'test_helper'

class JsonParserTest < ActiveSupport::TestCase
  include JsonParser

  test 'parse_json_data parses JSON data and calculates balance correctly' do
    json_data = [
      {
        "activity_id" => "1",
        "date" => "2014-10-01T01:00:29+00:00",
        "type" => "DEPOSIT",
        "amount" => 1003.75,
        "balance" => 1003.75,
        "requester" => {
          "type" => "INVESTMENT"
        },
        "source" => {
          "type" => "EXTERNAL",
          "id" => 18238147,
          "description" => "Chase ** 9867"
        },
        "destination" => {
          "type" => "INVESTOR",
          "id" => 76510190788,
          "description" => "Michael Daugherty"
        }
      }
    ]

    parsed_transactions = parse_json_data(json_data)

    assert_equal 1, parsed_transactions.length

    transaction = parsed_transactions.first
    assert_equal "1", transaction.activity_id
    assert_equal "2014-10-01T01:00:29+00:00", transaction.date
    assert_equal "DEPOSIT", transaction.type
    assert_equal 1003.75, transaction.amount
    assert_equal 1003.75, transaction.balance
    assert_equal "INVESTMENT", transaction.requester['type']
    assert_equal "EXTERNAL", transaction.source['type']
    assert_equal 18238147, transaction.source['id']
    assert_equal "Chase ** 9867", transaction.source['description']
    assert_equal "INVESTOR", transaction.destination['type']
    assert_equal 76510190788, transaction.destination['id']
    assert_equal "Michael Daugherty", transaction.destination['description']
  end

  test 'parse_json_data filters out duplicate activity IDs' do
    json_data_with_duplicates = [
      {
        "activity_id" => "1",
        "date" => "2014-10-01T01:00:29+00:00",
        "type" => "DEPOSIT",
        "amount" => 1003.75,
        "balance" => 1003.75,
        "requester" => {
          "type" => "INVESTMENT"
        },
        "source" => {
          "type" => "EXTERNAL",
          "id" => 18238147,
          "description" => "Chase ** 9867"
        },
        "destination" => {
          "type" => "INVESTOR",
          "id" => 76510190788,
          "description" => "Michael Daugherty"
        }
      },
      {
        "activity_id" => "1",
        "date" => "2014-10-01T01:00:29+00:00",
        "type" => "DEPOSIT",
        "amount" => 1003.75,
        "balance" => 1003.75,
        "requester" => {
          "type" => "INVESTMENT"
        },
        "source" => {
          "type" => "EXTERNAL",
          "id" => 18238147,
          "description" => "Chase ** 9867"
        },
        "destination" => {
          "type" => "INVESTOR",
          "id" => 76510190788,
          "description" => "Michael Daugherty"
        }
      },
    ]
    puts 'PARSED', JSON.parse(json_data_with_duplicates)
    parsed_transactions = parse_json_data(json_data_with_duplicates)

    assert_equal 1, parsed_transactions.length

    transaction = parsed_transactions.first
    assert_equal "1", transaction.activity_id
    assert_equal "2014-10-01T01:00:29+00:00", transaction.date
    assert_equal "DEPOSIT", transaction.type
    assert_equal 1003.75, transaction.amount
    assert_equal 1003.75, transaction.balance
    assert_equal "INVESTMENT", transaction.requester['type']
    assert_equal "EXTERNAL", transaction.source['type']
    assert_equal 18238147, transaction.source['id']
    assert_equal "Chase ** 9867", transaction.source['description']
    assert_equal "INVESTOR", transaction.destination['type']
    assert_equal 76510190788, transaction.destination['id']
    assert_equal "Michael Daugherty", transaction.destination['description']
  end
end
