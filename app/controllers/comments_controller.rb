class CommentsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_ticket, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @comment = Comment.new(
      user: current_user,
      message: message,
      commented_on_id: commented_on_id,
      commented_on_type: commented_on_type
    )

    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: projects_path }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@project, @ticket], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to [@project, @ticket], notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :message, :commented_on_type, :commented_on_id)
    end

    def comment_update_params
      params.permit(:message)
    end

    def message
      comment_params[:message].presence
    end

    def commented_on_id
      comment_params[:commented_on_id].presence
    end

    def commented_on_type
      comment_params[:commented_on_type].presence || 'Ticket'
    end
end
