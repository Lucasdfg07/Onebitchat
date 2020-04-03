class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :user_id
      t.integer :messagable_id
      t.string :messagable_type

      t.timestamps
    end
  end
end
