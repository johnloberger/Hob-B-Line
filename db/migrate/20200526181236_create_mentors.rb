class CreateMentors < ActiveRecord::Migration[5.0]
  def change
    create_table :mentors do |t|
      t.string :full_name
      t.integer :age
      t.string :favorite_hobby
      t.string :gender
      t.string :location 
    end
  end
end
