class User < ActiveRecord::Base

  attr_accessor :day, :month, :year
  
  email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  alphanumeric_format = /^\w+$/i

  ALPHANUMERIC_FORMAT_MESSAGE = "can only contain letters and numbers"

  MONTHS = ["January", 1], ["February", 2], ["March", 3], ["April", 4], ["May", 5], ["June", 6], ["July", 7], ["August", 8], ["September", 9], ["October", 10], ["November", 11], ["December", 12]
  DAYS = 1..31
  YEAR_RANGE = 1901..2008

  validates :username,
    :length     => { :in => 5..50 },
    :uniqueness => { :case_sensitive => false },
    :format     => { :with => alphanumeric_format, :message => ALPHANUMERIC_FORMAT_MESSAGE },
    :exclusion  => { :in => %w(admin Admin) },
    :unless     => Proc.new {|c| c.username.blank?}
  validates :username,
    :presence   => true,
    :if         => Proc.new {|c| c.username.blank?}
  validates :password,
    :presence   => true,
    :on         => :create,
    :if         => Proc.new {|c| c.password.blank?}
  validates :password,
    :confirmation => true,
    :length     => { :in => 6..50 },
    :on         => :create,
    :unless     => Proc.new {|c| c.password.blank?}
  validates :first_name,
    :presence   => true,
    :if         => Proc.new {|c| c.first_name.blank?}
  validates :first_name,
    :length     => { :maximum => 50 },
    :format     => { :with => alphanumeric_format, :message => ALPHANUMERIC_FORMAT_MESSAGE },
    :unless     => Proc.new {|c| c.first_name.blank?}
  validates :last_name,
    :presence   => true,
    :if         => Proc.new {|c| c.last_name.blank?}
  validates :last_name,
    :length     => { :maximum => 50 },
    :format     => { :with => alphanumeric_format, :message => ALPHANUMERIC_FORMAT_MESSAGE },
    :unless     => Proc.new {|c| c.last_name.blank?}
  validates :gender,
    :presence   => true,
    :length     => { :maximum => 6 }
  validates :email,
    :confirmation => true,
    :length     => { :maximum => 100 },
    :uniqueness => { :case_sensitive => false },
    :format     => { :with => email_format },
    :unless     => Proc.new {|c| c.email.blank?}
  validates :email,
    :presence   => true,
    :if         => Proc.new {|c| c.email.blank?}
  validates :user_type,
    :length     => { :maximum => 6 },
    :inclusion  => { :in => %w(Seller Bidder), :message => "%{value} is not a valid user type" },
    :unless     => Proc.new {|c| c.user_type.blank?}
  validates :user_type,
    :presence   => true,
    :if         => Proc.new {|c| c.user_type.blank?}
  
  validate :validate_birth_date
  validate :validate_birth_date_range, :unless     => Proc.new {|c| c.year.blank?}
  validates :terms_of_service, :acceptance => true
  validates :email_confirmation, :presence => true

  before_save :prepare_birth_date

  private
  
  def birth_date_range
    birth_date_year = self.year
    case birth_date_year.to_i
    when YEAR_RANGE
      true
    else
      false
    end
  end

  def prepare_birth_date
    begin
      unless year.blank?
        self.birth_date = Date.new(self.year.to_i, self.month.to_i, self.day.to_i)
      end
    rescue ArgumentError
      false
    end
  end
  
  def validate_birth_date
    errors.add("Birth date", "is invalid") unless prepare_birth_date
  end

  def validate_birth_date_range
    errors.add("Birth date", "is between year of 1901 to 2008") unless birth_date_range
  end

  def self.validate_username(username)
    self.where(:username => username).exists?
  end
  #scope :is_existing, lambda { |username| where("username = ?", username)}

end