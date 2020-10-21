module Tickets
  class SubmitTicket
    attr_reader :user, :params, :ticket, :errors

    # @param user [User] The User that created or up the ticket
    # @param params [ActionController::Parameters] The params the user submitted when creating the ticket
    # @option params [String] :id The associated Ticket#id - for the update case
    # @option params [String] :project The associated Project
    # @option params [String] :title The current Ticket#title
    # @option params [String] :description The current Ticket#description
    # @option params [String] :status The current Ticket#status
    # @option params [String] :priority The current Ticket#priority
    #
    def initialize(user:, params:, project:, ticket: nil)
      @user = user
      @params = params
      @project = project
      @ticket = ticket
      @assignee_ids = set_assignee_ids
    end

    def save
      create_ticket_transaction
      trigger_notifications
      success?
    end

    def update
      update_ticket!
      assign_recipients!
      trigger_notifications
      success?
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError => e
      @errors = e.message
      false
    end

  private

    attr_reader :project, :assignee_ids

    def set_assignee_ids
      if params[:assignees].present?
        params[:assignees]
          .split(',')
          .map { |id| id.strip.to_i }
      else
        []
      end
    end

    def create_ticket_transaction
      ActiveRecord::Base.transaction do
        create_ticket!
        assign_recipients!
      rescue ActiveRecord::RecordInvalid => e
        @errors = e.message.gsub('Validation failed: ', '')
        false
      end
    end

    def create_ticket!
      @ticket = user.tickets.new(
        project: project,
        title: params[:title].presence,
        description: params[:description].presence,
        status: params[:status].presence,
        priority: params[:priority].presence
      )

      @ticket.save!
    end

    def update_ticket!
      attrs = {
        title: params[:title].presence,
        description: params[:description].presence,
        status: params[:status].presence,
        priority: params[:priority].presence
      }

      ticket.update!(attrs)
    end

    def assign_recipients!
      assignee_ids.each do |assignee_id|
        assignee = User.find_by!(id: assignee_id)
        if !ticket.assignees.include?(assignee)
          TicketAssignee.create!(ticket: ticket, user_id: assignee.id)
        end
      end
    end

    def trigger_notifications
      if success? && ticket.persisted?
        ::Notifications::TicketAssignedJob.perform_later(ticket_id: ticket.id)
      end
    end

    def success?
      errors.blank?
    end
  end
end
