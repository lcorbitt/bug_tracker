require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { create :notification }

  describe 'validations' do
    it 'has a valid factory' do
      expect(notification).to be_valid
    end
  end

  describe 'associations' do
    let(:notification) { create :notification }

    it 'has a polymorphic relationship' do
      expect(notification).to belong_to :notified_of
    end
  end
end
