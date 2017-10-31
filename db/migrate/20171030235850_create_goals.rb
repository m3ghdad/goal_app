class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :detail, null: false
      t.boolean :private, default: false, null: false
      t.boolean :completed, default: false, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :goals, :user_id
  end
end
