Mentor.delete_all
Mentee.delete_all
Pairing.delete_all
# ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'mentors'")
# ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'mentees'")
# ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'pairings'")
steven = Mentor.create(full_name: "Steven Kandow", age: 34, gender: "male", favorite_hobby: "basket-weaving", location: "middle-of-nowhere")
john = Mentor.create(full_name: "John Loberger", age: 23, gender: "male", favorite_hobby: "video games", location: "Middle Earth")
mike = Mentee.create(full_name: "Mike Wyzowski", age: 17, gender: "male", favorite_hobby: "basket-weaving", location: "Middle Earth", guardian_contact: "Randall Scary_monster")
sully = Mentee.create(full_name: "Sully Bluemonster", age: 24, gender: "male", favorite_hobby: "scaring", location: "middle-of-nowhere")
# pairing_one = Pairing.new 
# pairing_one.mentor = steven 
# pairing_one.mentee = sully
pairing_two = Pairing.create(mentor: steven, mentee: mike)