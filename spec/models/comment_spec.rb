require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create :comment }

  describe 'validations' do
    it 'has a valid factory' do
      expect(comment).to be_valid
    end
  end
end
