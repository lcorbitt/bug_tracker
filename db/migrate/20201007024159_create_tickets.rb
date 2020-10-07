class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.references :project, null: false, foreign_key: true
      t.text :description, null: false
      t.integer :priority, null: false, default: 0

      t.timestamps
    end
  end
end
