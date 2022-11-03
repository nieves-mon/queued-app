class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2, maximum: 25}
  validates :due_date, presence: true
end
