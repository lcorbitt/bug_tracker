class Notification < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipient, class_name: 'User'
  belongs_to :notified_of, polymorphic: true

  validates :action, presence: true

  scope :unread, -> { where(read_at: nil) }
  # scope :unseen, -> { where(seen_at: nil) }

  DROPDOWN_LENGTH = 20

  # Creates the ActiveRecord::Enum mappings between the attribute values and
  # their associated database integers. Also creates a constant for each value.
  #
  # To add a new value, add it to the **end** of the hash, incrementing the integer.
  #
  # Do **NOT** remap any existing attributes or integers.
  #
  # @see https://api.rubyonrails.org/v5.2/classes/ActiveRecord/Enum.html
  #
  ENUM_ACTION_VALUE_MAPPINGS = {
    assigned: 0,
    commented: 1
  }.each_key do |subject|
    const_set(subject.upcase, subject)
  end

  enum action: ENUM_ACTION_VALUE_MAPPINGS

  def self.for(recipient_id)
    self
      .where(recipient_id: recipient_id)
      .order(created_at: :desc)
  end

  def new?
    read_at.nil?
  end
end
