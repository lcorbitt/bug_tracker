module Tickets
  class SubmitTicket
    attr_reader :user, :params, :ticket, :errors

    # @param user [User] The User that created the ticket
    # @param params [ActionController::Parameters] The params the user submitted when creating the ticket
    # @option params [String] :id The associated Ticket#id - for the update case
    # @option params [String] :project_id The associated Project#id
    # @option params [String] :description The current Ticket#description
    #
    def initialize(user:, project:, params:)
      @user = user
      @project = project
      @params = params
      @assignee_ids = set_assignee_ids
    end

    def save
      if @project.present?
        create_ticket_transaction
        # trigger_notifications
        success?
      else
        @errors = 'Ticket must be assigned to a Project.'
        false
      end
    rescue ArgumentError => e
      @errors = e.message
      false
    end

  private

    attr_reader :project, :assignee_ids

    def set_assignee_ids
      if params[:assignees] != 'none'
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
      @ticket = @project.tickets.new(
        user: user,
        title: params[:title].presence,
        description: params[:description].presence,
        status: params[:status].presence,
        priority: params[:priority].presence
      )
      @ticket.save!
    end

    def assign_recipients!
      assignee_ids.each do |assignee_id|
        assignee = User.find_by!(id: assignee_id)
        TicketAssignee.create!(ticket: ticket, user_id: assignee.id)
      end
    end

    def success?
      errors.blank?
    end
  end
end
