module Notifications
  class TicketCommentedJob < ApplicationJob
    queue_as :default

    def perform(comment_id:)
      comment = Comment
        .includes(:user, commented_on: [:user])
        .find_by!(id: comment_id)
      ticket = comment.commented_on
      ticket_author = comment.commented_on.user

      return if ticket_author == comment.user

      Notification.create(
        user: comment.user,
        action: Notification::COMMENTED,
        recipient: ticket_author,
        notified_of: comment
      )
    end
  end
end
