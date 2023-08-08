class Entity
  attr_accessor :id, :type, :description

  def initialize(attributes)
    attributes.each { |key, value| send("#{key}=", value) }
  end
end
