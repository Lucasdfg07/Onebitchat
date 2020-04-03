class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.integer :user_one_id
      t.integer :user_two_id
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
