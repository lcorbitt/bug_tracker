class CreateTicketAssignees < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_assignees do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { to_table: :users }
    end
  end
end
