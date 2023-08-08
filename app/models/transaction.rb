class Transaction

  attr_accessor :activity_id, :date, :type, :method, :amount, :balance,
                :requester, :source, :destination, :calculated_balance

  TRANSACTION_TYPE = [DEPOSIT = 'DEPOSIT', INVESTMENT = 'INVESTMENT', REFUND: 'REFUND', WITHDRAWAL: 'WITHDRAWAL', TRANSFER: 'TRANSFER']

  def initialize(attributes = {})
    attributes.each { |key, value| send("#{key}=", value) }
    @requester = Requester.new(attributes['requester']) if attributes['requester']
    @source = Source.new(attributes['source']) if attributes['source']
    @destination = Destination.new(attributes['destination']) if attributes['destination']
  end

  def self.convert_date(datetime)
    time = Time.parse(datetime).in_time_zone("UTC")
    time.strftime("%-d/%-m/%y")
  end

  def self.convert_time(datetime)
    time = Time.parse(datetime).in_time_zone("UTC")
    time.strftime("%-d/%-m/%y - %H:%M:%S ")
  end

  def self.transaction_description(transaction)
    source_description = ""
    destination_description = ""
    source_type = ""
    # description = "A #{transaction&.type.titleize} has been made"

    if transaction&.source.[]('description').present?
      source_description = transaction&.source.[]('description')
    end
    source_type = transaction&.source.[]('type') if  transaction&.source.[]('type').present?
    destination_type = transaction&.destination.[]('type') if transaction&.destination.[]('type').present?
    destination_description = transaction&.destination.[]('description') if  transaction&.destination.[]('description').present?

    "#{source_description} has made a #{source_type.titleize} transaction towards #{destination_description}"
  end

  def total_balance

  end

  def type_enum
    TransactionType.types
  end
end
