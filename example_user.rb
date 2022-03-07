class User
  attr_accessor :name, :email

  def initialize(attributes = {})
    @first_name = attributes[:name].split(' ').first
    @last_name = attributes[:name].split(' ').last
    @email = attributes[:email]
  end

  def formatted_email
    "#{full_name} <#{@email}>"
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def alphabetical_name
    "#{@last_name}, #{@first_name}"
  end
end
