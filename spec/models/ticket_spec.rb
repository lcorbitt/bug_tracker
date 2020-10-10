require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { create :ticket }

  describe 'validations' do
    it 'has a valid factory' do
      expect(ticket).to be_valid
    end
  end

  describe 'associations' do
    describe 'has_many :comments' do
      let(:comment) { create :comment, commented_on: ticket }

      it 'associates a Ticket with its Comment' do
        expect(ticket.comments).to include comment
      end
    end
  end
end
