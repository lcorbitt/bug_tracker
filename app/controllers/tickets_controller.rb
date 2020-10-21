class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :edit, :update, :show, :destroy]
  before_action :set_ticket, only: [:edit, :update, :destroy, :show]

  def index
    @tickets = Ticket.for_user_or_assignee(current_user)
    @paginated_tickets = @tickets.paginate(page: page, per_page: 10)
  end

  def new
    @ticket = Ticket.new
  end

  def show
    @comment = Comment.new
    @comments = Comment.for(commented_on_id: @ticket.id).reverse
  end

  def edit
  end

  def create
    submit_ticket = Tickets::SubmitTicket.new(
      user: current_user,
      params: ticket_params,
      project: @project
    )

    if submit_ticket.save
      redirect_to @project, notice: 'You created a ticket for this project!'
    else
      render plain: submit_ticket.errors, status: :bad_request
    end
  end

  def update
    submit_ticket = Tickets::SubmitTicket.new(
      user: current_user,
      params: ticket_params,
      project: @project,
      ticket: @ticket
    )

    if submit_ticket.update
      redirect_to [@project, @ticket], notice: 'Ticket updated successfully!'
    else
      render plain: submit_ticket.errors, status: :bad_request
    end
  end

  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Ticket was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:id, :user_id, :title, :status, :description, :priority, :assignees, :project_id)
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def page
      params[:page]
    end
end
