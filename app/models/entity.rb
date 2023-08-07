class Entity

  #has_many :requester_transactions, class_name: 'Transaction', foreign_key: 'requester_id'
  #has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_id'
  #has_many :destination_transactions, class_name: 'Transaction', foreign_key: 'destination_id'

  # Additional methods or validations can be added here
  attr_accessor :id, :type, :description

  def initialize(attributes)
    attributes.each { |key, value| send("#{key}=", value) }
  end
end
