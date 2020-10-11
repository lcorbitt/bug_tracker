require 'rails_helper'

RSpec.describe Tickets::SubmitTicket do
  let(:user) { create :user }
  let(:project) { create :project }

  describe '#save' do
    let(:params) do
      ActionController::Parameters.new(
        title: 'some title',
        description: 'some description',
        status: 'in_progress',
        priority: 'medium'
      )
    end

    let(:submit_ticket) { Tickets::SubmitTicket.new(user: user, project: project, params: params) }

    context 'happy path' do
      it 'creates a Ticket for the passed user', :aggregate_failures do
        expect(user.tickets.count).to eq 0

        params.permit!

        submit_ticket.save
        ticket = user.tickets.first

        expect(ticket).to be_present
        expect(ticket.user_id).to eq user.id
      end

      it 'does not set #errors' do
        params.permit!

        submit_ticket.save

        expect(submit_ticket.errors).to be_nil
      end
    end
    context 'with an assignee' do
      let(:jane) { create :user }
      let(:john) { create :user }

      let(:params) do
        ActionController::Parameters.new(
          title: 'some title',
          description: 'some description with assignees',
          status: 'in_progress',
          priority: 'medium',
          assignees: "#{jane.id}, #{john.id}"
        )
      end

      it 'creates a Ticket for the passed user', :aggregate_failures do
        expect(user.tickets.count).to eq 0
        params.permit!

        submit_ticket.save
        ticket = user.tickets.first

        expect(ticket).to be_present
        expect(ticket.user_id).to eq user.id
      end

      it "creates a TicketAssignee for each of the passed assignees", :aggregate_failures do
        expect(jane.ticket_assignees.count).to eq 0
        expect(john.ticket_assignees.count).to eq 0
        params.permit!

        submit_ticket.save

        ticket = user.tickets.first

        ticket_assignee1 = jane.ticket_assignees.first
        ticket_assignee2 = john.ticket_assignees.first

        expect(ticket_assignee1).to be_present
        expect(ticket_assignee2).to be_present
        expect(ticket.ticket_assignees).to include ticket_assignee1
        expect(ticket.ticket_assignees).to include ticket_assignee2
      end
    end
  end
end
