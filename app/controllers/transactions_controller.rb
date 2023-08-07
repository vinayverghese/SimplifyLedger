# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController

  def index
    @transactions = Rails.cache.read('transactions')
    @total_balance = @transactions.last.balance
  end

  def create
    @transactions
  end
  def upload
    uploaded_file = params[:json_file]
    # Rails.cache.clear

    if uploaded_file.present?
      json_data = JSON.parse(uploaded_file.read)
      @transactions = parse_json_data(json_data)
      @total_balance = calculate_total_balance
      puts('TRANSACTIONS', @transactions)
      Rails.cache.write('transactions',  @transactions)

      redirect_to transactions_path
      #redirect_to transactions_path(transactions_data: @transactions, total_balance: @total_balance)
    else
      flash.now[:error] = 'Please select a JSON file to upload.'
      render :upload_form
    end
  end

  def parse_json_data(json_data = nil)
    total_balance = 0
    activity_ids = Set.new

    transactions = json_data.map do |activity_data|
      next if activity_ids.include?(activity_data['activity_id'])

      activity_ids << activity_data['activity_id']

      transaction = Transaction.new(
        activity_id: activity_data['activity_id'],
        date: activity_data['date'],
        type: activity_data['type'],
        amount: activity_data['amount'],
        balance: activity_data['balance'],
        requester: activity_data['requester'],
        source: activity_data['source'],
        destination: activity_data['destination']
      )
      total_balance += transaction.amount
      transaction
    end.compact.sort_by { |t| t.date }

    final_transaction = transactions.last
    puts "Final balance: #{total_balance}"
    puts "Expected final balance: #{final_transaction.balance}"

    @total_balance = total_balance
    puts 'PARSED TRANSACTIONS AFTER FIX', transactions.size
    transactions.to_a
  end

  def upload_form
    Rails.cache.clear
    # This is the action to render the file upload form
  end

  private

  def all_transactions
    @transactions
  end

  def calculate_total_balance
    # @transactions.last.balance if @transactions.present?
  end
end
