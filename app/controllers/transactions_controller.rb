class TransactionsController < ApplicationController
  include JsonParser
  add_flash_types :info, :error, :warning

  def index
    @error_message = ''
    json_data = params[:transactions]
    output = parse_json_data(json_data)
    @transactions = output
    @total_balance = @transactions.first.balance
    @start_date = @transactions.last.date
    @end_date = @transactions.first.date
  end

  def upload
    begin
      uploaded_file = params[:json_file]
      if uploaded_file.present?
        json_data = JSON.parse(uploaded_file.read)
        @transactions = parse_json_data(json_data)

        redirect_to transactions_path(:transactions => json_data)
      else
        flash.now[:error] = 'Please select a JSON file to upload.'
        @error_message = 'Please select a JSON file to upload.'
        render :upload_form, notice: 'Error'
      end
    rescue JSON::ParserError => e
      @error_message = 'ERROR: This is not a valid JSON file.'
      flash.now[:error] = 'ERROR: This is not a valid JSON file'
    end
  end

  def upload_form
  end

  private
end
