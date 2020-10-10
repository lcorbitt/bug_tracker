class Project < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :tickets
  validates :name, presence: true
  validates :description, presence: true
end
