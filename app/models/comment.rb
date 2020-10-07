class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commented_on, polymorphic: true

  validates :message, presence: true

  def self.for(commented_on_id:, commented_on_type: 'Ticket')
    self
      .includes(:user)
      .where(commented_on_id: commented_on_id, commented_on_type: commented_on_type)
      .order(created_at: :desc)
  end
end
