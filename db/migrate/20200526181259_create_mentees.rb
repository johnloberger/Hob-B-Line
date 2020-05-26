class CreateMentees < ActiveRecord::Migration[5.0]
  def change
    create_table :mentees do |t|
      t.string :full_name
      t.integer :age
      t.string :favorite_hobby
      t.string :gender
      t.string :location 
      t.string :guardian_contact
    end
  end
end
