require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'methods tests' do
    it 'getFullName works correctly' do
      user = User.new(first_name: 'fname', last_name: 'lname')
      expect(user.getFullName).to eq('fname lname')
    end
  end
end
