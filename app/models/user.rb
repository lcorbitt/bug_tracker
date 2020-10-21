class User < ApplicationRecord
  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notifications, as: :recipient
  has_many :projects
  has_many :tickets
  has_many :ticket_assignees, dependent: :destroy, foreign_key: :user_id
  has_many :comments, dependent: :destroy

  validates :email, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username

  validates_uniqueness_of :email
  validates_uniqueness_of :username

  # Creates the ActiveRecord::Enum mappings between the attribute values and
  # their associated database integers. Also creates a constant for each value.
  #
  # To add a new value, add it to the **end** of the hash, incrementing the integer.
  #
  # Do **NOT** remap any existing attributes or integers.
  #
  # @see https://api.rubyonrails.org/v5.2/classes/ActiveRecord/Enum.html
  #
  ENUM_ROLE_MAPPINGS = {
    admin: 0,
    employee: 1
  }.each_key do |subject|
    const_set(subject.upcase, subject)
  end

  enum role: ENUM_ROLE_MAPPINGS

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def login
    @login || self.username || self.email
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
