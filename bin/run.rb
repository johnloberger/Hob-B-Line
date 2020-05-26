require_relative '../config/environment'


def clear_screen!
  puts "\e[H\e[2J"
end

clear_screen!
puts "Welcome to Hob-B-Line, please enter 'mentor' or 'mentee'."
puts
puts
print "You are a: "

entered_role = gets.chomp

if entered_role == "mentor" || entered_role == "mentee"

  clear_screen!
  puts "Hello #{ entered_role }! Please enter your full name below!"
  puts
  puts
  print "Full Name: "

  entered_name = gets.chomp

  if entered_role == "mentor"
    clear_screen!
    puts "Welcome #{ entered_name }! Here is a list of all available mentees!"
    puts
    puts
    puts Mentee.all

  elsif entered_role == "mentee"
    clear_screen!
    puts "Welcome #{ entered_name }! Here is a list of all available mentors!"
    puts
    puts
    puts Mentor.all

  else
    puts "Sorry, name was not found. Please re-enter with a valid name!"
  end

else 

  clear_screen!
  puts "Please enter a valid role."
  puts 
  puts
  print "You are a: "

  entered_role

end




puts "HELLO WORLD"
