class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, :due_date, presence: true
end
