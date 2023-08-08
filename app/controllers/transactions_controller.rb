class TransactionsController < ApplicationController
  include JsonParser
  add_flash_types :info, :error, :warning

  def index
    @error_message = ''
    @transactions = Rails.cache.read('transactions')
    @total_balance = calculate_total_balance
    @start_date = @transactions.last.date
    @end_date = @transactions.first.date
  end

  def create
    @transactions
  end
  def upload
    Rails.cache.clear
    begin
      uploaded_file = params[:json_file]
      if uploaded_file.present?
        json_data = JSON.parse(uploaded_file.read)
        @transactions = parse_json_data(json_data)
        Rails.cache.write('transactions', @transactions)

        redirect_to transactions_path
      else
        flash.now[:error] = 'Please select a JSON file to upload.'
        @error_message = 'Please select a JSON file to upload.'
        render :upload_form, notice: 'Error'
      end
    rescue JSON::ParserError => e
      puts 'parser error'
      @error_message = 'ERROR: This is not a valid JSON file.'

      flash.now[:error] = 'ERROR: This is not a valid JSON file'
    end
    puts('ERROR_MSG', @error_message)
  end

  def upload_form
  end

  private

  def calculate_total_balance
    if @transactions.present?
      if @transactions.last.calculated_balance != @transactions.last.balance
        @transactions.last.calculated_balance
      else
        @transactions.last.balance
      end
    end
  end
end
