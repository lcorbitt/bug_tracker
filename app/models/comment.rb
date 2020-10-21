class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commented_on, polymorphic: true

  has_many :notifications, as: :notified_of, dependent: :destroy

  validates :message, presence: true

  after_create :notify_users

  def self.for(commented_on_id:, commented_on_type: 'Ticket')
    self
      .includes(:user)
      .where(commented_on_id: commented_on_id, commented_on_type: commented_on_type)
      .order(created_at: :desc)
  end

  def notify_users
    Notifications::TicketCommentedJob.perform_later(comment_id: id)
  end
end
