class Transaction

  attr_accessor :activity_id, :date, :type, :method, :amount, :balance,
                :requester, :source, :destination

  def initialize(attributes = {})
    attributes.each { |key, value| send("#{key}=", value) }
    @requester = Requester.new(attributes['requester']) if attributes['requester']
    @source = Source.new(attributes['source']) if attributes['source']
    @destination = Destination.new(attributes['destination']) if attributes['destination']
  end

  def self.convert_time(datetime)
    time = Time.parse(datetime).in_time_zone("UTC")
    time.strftime("%-d/%-m/%y: %H:%M:%S ")
  end

  def self.transaction_description(transaction)
    #puts "TRANSACTION REQUESTER", transaction.requester&.[]('type').titleize
    #puts "TRANSACTION REQUESTER type", transaction.requester['type']
    #puts "TRANSACTION SOURCE type", transaction.source['type']
    #puts "TRANSACTION SOURCE description", transaction.source['description']
    #puts "TRANSACTION DESTINATION description", transaction.destination['description']
    #{transaction&.requester['type']} made from
    if transaction&.source.[]('description').present?
    "#{transaction&.source.[]('description')} to #{transaction&.destination.[]('type')} / #{transaction&.destination.[]('description')}"
    else
      "#{transaction&.destination.[]('type')} / #{transaction&.destination.[]('description')}"
    end
  end

  def total_balance

  end

  def type_enum
    TransactionType.types
  end
end
