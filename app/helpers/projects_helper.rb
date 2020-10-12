module ProjectsHelper
  def format_status(status)
    if status.include?("_")
      status.downcase.tr!("_", " ").titleize
    else
      return status.titleize
    end
  end

  def row_color(ticket_priority)
    if ticket_priority == "low"
      "table-success"
    elsif ticket_priority == "medium"
      "table-warning"
    elsif ticket_priority == "high"
      "table-danger"
    else
      "table-light"
    end
  end

  def priority_badge_color(priority)
    if priority == Ticket::NONE.to_s
      "badge-light"
    elsif priority == Ticket::LOW.to_s
      "badge-success"
    elsif priority == Ticket::MEDIUM.to_s
      "badge-warning"
    else
      "badge-danger"
    end
  end
end
