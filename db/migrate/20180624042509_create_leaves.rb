class CreateLeaves < ActiveRecord::Migration[5.1]
  def change
    create_table :leaves do |t|
      t.string :date
      t.string :leavetype
      t.text :reason
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
