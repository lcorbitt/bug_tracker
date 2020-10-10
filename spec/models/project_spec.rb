require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { create :project }

  describe 'validations' do
    it 'has a valid factory' do
      expect(project).to be_valid
    end
  end

  describe 'associations' do
    describe 'has_many :tickets' do
      let(:ticket) { create :ticket, project: project }

      it 'associates a Project with its Ticket' do
        expect(project.tickets).to include ticket
      end
    end
  end
end
