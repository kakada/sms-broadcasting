class CreateTesters < ActiveRecord::Migration[6.0]
  def change
    create_table :testers do |t|
      t.integer :age
      t.string :gender
      t.string :phone_number
      t.string :lab_code
      t.references :broadcast, null: false, foreign_key: true

      t.timestamps
    end
  end
end
