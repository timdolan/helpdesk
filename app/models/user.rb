class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessible :last_name, :first_name, :middle_name, :employee_number, :email, :work_phone, :cell_phone, :worker, :location_id, :password, :password_confirmation

  belongs_to :location
  has_many :locations, :foreign_key => "user_id"
  has_many :bulletins

  validates :last_name,             :presence => true
  validates :first_name,            :presence => true
  validates :employee_number,       :presence => true,
                                    :length => { :is => 6 }
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,     :presence => true,
                        :format => { :with => email_regex }

  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 }

  before_save :encrypt_password

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  private

    def encrypt_password
        self.salt = make_salt if new_record?
        self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
  
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
  
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
