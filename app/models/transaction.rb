class Transaction

  attr_accessor :activity_id, :date, :type, :method, :amount, :balance,
                :requester, :source, :destination, :calculated_balance

  TRANSACTION_TYPE = [DEPOSIT = 'DEPOSIT', INVESTMENT = 'INVESTMENT', REFUND: 'REFUND', WITHDRAWAL: 'WITHDRAWAL',  TRANSFER: 'TRANSFER']

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
    description = "A #{transaction&.type} has been made"
    source_type = ''
    source_description= ''
    destination_type =''
    destination_description =''

    #if transaction&.source.[]('description').present?
    "A #{transaction&.type} has been made: #{transaction&.source.[]('description')} To #{transaction&.destination.[]('type')} / #{transaction&.destination.[]('description')}"
    #else
    #  "#{transaction&.destination.[]('type')} / #{transaction&.destination.[]('description')}"
    #end
  end

  def total_balance

  end

  def type_enum
    TransactionType.types
  end
end
