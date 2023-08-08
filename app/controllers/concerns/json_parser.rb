module JsonParser
  def parse_json_data(json_data = nil)
    calculated_balance = 0
    activity_ids = Set.new
    if json_data.present?
      transactions = json_data.map do |activity_data|
        next if activity_ids.include?(activity_data['activity_id'])

        activity_ids << activity_data['activity_id']

        transaction = Transaction.new(
          activity_id: activity_data['activity_id'],
          date: activity_data['date'],
          type: activity_data['type'],
          amount: activity_data['amount'].to_f,
          balance: activity_data['balance'].to_f,
          requester: activity_data['requester'],
          source: activity_data['source'],
          destination: activity_data['destination']
        )
        calculated_balance += transaction.amount
        transaction.calculated_balance = calculated_balance
        transaction
      end.compact.sort_by { |t| t.date }.reverse!

      final_transaction = transactions.last
      puts "Final balance: #{calculated_balance}"
      puts "Expected final balance: #{final_transaction.balance}"

      transactions.to_a
    end
  end
end