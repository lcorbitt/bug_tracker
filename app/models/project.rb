class Project < ApplicationRecord
  belongs_to :user
  has_many :tickets

  accepts_nested_attributes_for :tickets
end
