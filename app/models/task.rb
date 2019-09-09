class Task < ApplicationRecord
  validates :title, length: { minimum: 5, maximum: 40 }
  validates :description,  length: { minimum: 5, maximum: 500 }
  validates :priority,  numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validate :due_date_cannot_be_in_the_past
  belongs_to :user

  def due_date_cannot_be_in_the_past
    unless due_date.nil?
      unless due_date > Date.today
        errors.add(:due_date, "must be in the future")
      end
    else
      errors.add(:due_date, "can't be a blank")
    end

  end

end