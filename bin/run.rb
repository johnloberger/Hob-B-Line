require_relative '../config/environment'
require 'tty-prompt'

def clear_screen!
  puts "\e[H\e[2J"
end

def mentor_login
clear_screen!
puts "Hello Mentor! Please enter your full name below!"
puts
puts
print "Full Name: "

entered_name = gets.chomp

clear_screen!
puts "Welcome #{ entered_name }! Here is a list of all available mentees!"
puts
puts
puts Mentee.all
end

def mentee_login
  clear_screen!
  puts "Hello Mentee! Please enter your full name below!"
  puts
  puts
  print "Full Name: "
  
  entered_name = gets.chomp
clear_screen!
puts "Welcome #{ entered_name }! Here is a list of all available mentors!"
puts
puts
puts Mentor.all
end

prompt = TTY::Prompt.new
puts "\e[H\e[2J"
welcome = prompt.select("Please select your role") do |menu|
  menu.choice 'Mentor'
  menu.choice 'Mentee'
end

if welcome == 'Mentor'
  mentor_login
elsif welcome == 'Mentee'
  mentee_login
end





# clear_screen!
# puts "Welcome to Hob-B-Line, please enter 'mentor' or 'mentee'."
# puts
# puts
# print "You are a: "

# while entered_role = gets.chomp
#   case entered_role 
#   when "mentor"
#     break 
#   when "mentee"
#     break
#   else 
#     clear_screen!
#     puts "Please input a valid role"
#     puts
#     print "You are a:"
#   end 
# end




# else
#   puts "Sorry, name was not found. Please re-enter with a valid name!"
# end

# puts
# puts "HELLO WORLD"
