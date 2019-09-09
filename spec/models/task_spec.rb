require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation tests' do
    it 'title must be longer or eq than 5 symbols' do
      record = Task.new
      record.title = ''
      record.valid?
      record.errors[:title].should include("is too short (minimum is 5 characters)")

      record.title = 'aaaaa'
      record.valid?
      record.errors[:title].should_not include("is too short (minimum is 5 characters)")
    end
    it 'due_date must be in the future' do
      record = Task.new
      record.due_date = Date.yesterday
      record.valid?
      record.errors[:due_date].should include("must be in the future")

      record.due_date = Date.today + 1
      record.valid?
      record.errors[:due_date].should_not include("must be in the future")
    end
  end
end
