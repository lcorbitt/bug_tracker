class AddTicketTypeToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :ticket_type, :integer
  end
end
