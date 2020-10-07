class TicketsController < ApplicationController
  before_action :set_project, only: [:new, :create, :edit, :update]
  before_action :set_ticket, only: [:edit, :update, :destroy]

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = @project.tickets.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @project, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
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
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def ticket_params
      params.require(:ticket).permit(:title, :status, :description, :priority).merge(user_id: current_user.id)
    end
end
