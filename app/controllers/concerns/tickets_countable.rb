module TicketsCountable
  extend ActiveSupport::Concern

  def total_tickets
    @total_tickets = current_user.tickets.size
  end

  def tickets_by_status
    @tickets_by_status = {
      new: new_tickets.size,
      open: open_tickets.size,
      in_progress: in_progress_tickets.size,
      resolved: resolved_tickets.size,
      more_info_needed: more_info_needed_tickets.size
    }
  end

  def tickets_by_priority
    @tickets_by_priority = {
      none: none_priority_tickets.size,
      low: low_priority_tickets.size,
      medium: medium_priority_tickets.size,
      high: high_priority_tickets.size
    }
  end

  def new_tickets
    current_user.tickets.where(status: Ticket::NEW)
  end

  def open_tickets
    current_user.tickets.where(status: Ticket::OPEN)
  end

  def in_progress_tickets
    current_user.tickets.where(status: Ticket::IN_PROGRESS)
  end

  def resolved_tickets
    current_user.tickets.where(status: Ticket::RESOLVED)
  end

  def more_info_needed_tickets
    current_user.tickets.where(status: Ticket::MORE_INFO_NEEDED)
  end

  def none_priority_tickets
    current_user.tickets.where(priority: Ticket::NONE)
  end

  def low_priority_tickets
    current_user.tickets.where(priority: Ticket::LOW)
  end

  def medium_priority_tickets
    current_user.tickets.where(priority: Ticket::MEDIUM)
  end

  def high_priority_tickets
    current_user.tickets.where(priority: Ticket::HIGH)
  end
end
