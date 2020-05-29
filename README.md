# Welcome to Hob-B-Line

This app is designed to connect individuals interested in learning or improving in a hobby with a mentor
in that same particular skill.

Hob-B-Line allows individuals to create accounts in two main roles providing the following data:

# Mentor: 
  1.  Full Name
  2.  Age
  3.  Gender
  4.  Favorite Hobby
  5.  Location

# Mentee:
  1.  Full Name
  2.  Age
  3.  Gender  
  4.  Favorite Hobby
  5.  Location
  6.  Guardian Contact (if the mentee is under age 18)

Once logged in, mentors and mentees will be able to carry out the following functions:

# Mentor:
  1.  See My Mentees - Provides a list of all mentees that have been paired with the mentor
  2.  Approve a Mentee - Allows the mentor to approve a pairing with a potential mentee
  3.  Delete a Pairing - Allows the mentor to delete a pairing with a particular mentee
  4.  Change My Hobby - Allows the mentor to change their favorite hobby
  5.  Log Out - Returns the mentor to the main login screen.
  6.  Exit - Exits the app

# Mentee:
  1.  See My Mentors - Provides two lists of both all approved and pending mentors.
  2.  Create a Pairing - Provides a list of all mentors in the database that share the mentee's favorite hobby and allows
      the mentee to create a pairing with one of these mentors
  3.  Delete a Pairing - Allows the mentee to delete a pairing with a particular mentor
  4.  Change My Hobby - Allows the mentee to change their favorite hobby
  5.  Log Out - Returns the mentee to the main login screen.
  6.  Exit - Exits the app

# How to Run:
  1.  Clone this repo
  2.  In your terminal, run 'bundle install'
  3.  Run 'rake db:create'
  4.  Run 'rake db:migrate'
  5.  Run 'rake db:seed'
  6.  Run 'ruby bin/run.rb' to start Hob-B-Line
