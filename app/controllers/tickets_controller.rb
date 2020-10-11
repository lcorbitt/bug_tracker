class TicketsController < ApplicationController
  before_action :set_project, only: [:new, :create, :edit, :update, :show, :destroy]
  before_action :set_ticket, only: [:edit, :update, :destroy, :show]

  def new
    @ticket = Ticket.new
  end

  def show
    @comment = Comment.new
    @comments = Comment.for(commented_on_id: @ticket.id)
  end

  def edit
  end

  def create
    submit_ticket = Tickets::SubmitTicket.new(
      user: current_user,
      project: @project,
      params: ticket_params
    )

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @project, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    if submit_ticket.save
      redirect_to @project, notice: 'You created a ticket for this project!'
    else
      render plain: submit_ticket.errors, status: :bad_request
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to [@project, @ticket], notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:user_id, :title, :status, :description, :priority, :assignees)
    end

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
