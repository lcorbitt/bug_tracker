class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :comments, as: :commented_on, dependent: :destroy
  has_many :ticket_assignees, dependent: :destroy
  has_many :assignees, through: :ticket_assignees, source: :user
  has_many :notifications, as: :notified_of, dependent: :destroy

  validates :title, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :priority, presence: true

  # Creates the ActiveRecord::Enum mappings between the attribute values and
  # their associated database integers. Also creates a constant for each value.
  #
  # To add a new value, add it to the **end** of the hash, incrementing the integer.
  #
  # Do **NOT** remap any existing attributes or integers.
  #
  # @see https://api.rubyonrails.org/v5.2/classes/ActiveRecord/Enum.html
  #
  ENUM_STATUS_MAPPINGS = {
    new: 0,
    open: 1,
    in_progress: 2,
    resolved: 3,
    more_info_needed: 4
  }.each_key do |subject|
    const_set(subject.upcase, subject)
  end

  enum status: ENUM_STATUS_MAPPINGS, _suffix: true

  ENUM_PRIORITY_MAPPINGS = {
    none: 0,
    low: 1,
    medium: 2,
    high: 3
  }.each_key do |subject|
    const_set(subject.upcase, subject)
  end

  enum priority: ENUM_PRIORITY_MAPPINGS, _suffix: true

  def self.for_project(project_id:)
    Ticket
      .includes(:user)
      .where(project_id: project_id)
      .order(created_at: :desc)
  end

  def self.for_user_or_assignee(user)
    Ticket
      .includes(:project, :user, :assignees, :ticket_assignees)
      .where(
        user: user
      )
      .or(
        Ticket
        .includes(:project, :user, :assignees, :ticket_assignees)
          .where(
            ticket_assignees: { user: user }
          )
      )
      .order(created_at: :desc)
  end
end
