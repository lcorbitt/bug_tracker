class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :tickets
  has_many :ticket_assignees, dependent: :destroy, foreign_key: :user_id
  has_many :comments, dependent: :destroy

  validates :email, presence: true
  validates :username, presence: true

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
end
