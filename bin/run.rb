require_relative '../config/environment'


def clear_screen!
  puts "\e[H\e[2J"
end

clear_screen!
puts "Welcome to Hob-B-Line, please enter 'mentor' or 'mentee'."
puts
puts
print "You are a: "

while entered_role = gets.chomp
  case entered_role 
  when "mentor"
    break 
  when "mentee"
    break
  else 
    clear_screen!
    puts "Please input a valid role"
    puts
    print "You are a:"
  end 
end

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

puts
puts "HELLO WORLD"
