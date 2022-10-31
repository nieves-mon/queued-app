class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :due_date, :title, presence: true
end
