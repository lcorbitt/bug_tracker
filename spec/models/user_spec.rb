require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'validations' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end
  end

  describe 'associations' do
    let(:project) { create :project, user: user }

    describe 'has_many :projects' do
      it 'associates a User with their Project' do
        expect(user.projects).to include project
      end
    end

    describe 'has_many :tickets' do
      let(:ticket) { create :ticket, project: project, user: user }

      it 'associates a User with their Ticket' do
        expect(user.tickets).to include ticket
      end
    end

    describe 'has_many :comments' do
      let(:ticket) { create :ticket, project: project, user: user }
      let(:comment) { create :comment, commented_on: ticket, user: user }

      it 'associates a User with their Comment' do
        expect(user.comments).to include comment
      end
    end
  end
end
