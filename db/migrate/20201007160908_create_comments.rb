class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :message
      t.string :commented_on_type
      t.bigint :commented_on_id

      t.timestamps
    end

    add_index :comments, [:commented_on_type, :commented_on_id]
  end
end
