class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :action, null: false
      t.integer :recipient_id, null: false
      t.integer :notified_of_id, null: false
      t.string :notified_of_type, null: false
      t.datetime :read_at

      t.timestamps
    end
  end
end
