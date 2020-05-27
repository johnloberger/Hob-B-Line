require_relative '../config/environment'
require 'pry'

# DEFINED METHODS
def clear_screen!
  puts "\e[H\e[2J"
end


# prompt = TTY::Prompt.new
# puts "\e[H\e[2J"
# menu = prompt.select("Welcome #{ entered_name }! Select one of the following menu options.") do |menu|
# menu.choice 'View Pairings'
# menu.choice 'Update Profile'


# if menu == 'View Pairings'
#   Pairing.all.map {|p| p.mentor.full_name == entered_name}
# end


def mentor_login
  clear_screen!
  puts "Hello Mentor! Please enter your full name below!"
  puts
  puts
  print "Full Name: "

  entered_name = gets.chomp
  current_user = Mentor.find_by(full_name: entered_name)

  clear_screen!
  if current_user
    puts "you are in the system."
  else
    puts "Sorry, not in the system."
  end
end

def mentee_login
  clear_screen!
  puts "Hello Mentee! Please enter your full name below!"
  puts
  puts
  print "Full Name: "
  
  entered_name = gets.chomp
  current_user = Mentee.find_by(full_name: entered_name)

  clear_screen!
  if current_user
    puts "you are in the system."
  else
    puts "Sorry, not in the system."
  end
end

prompt = TTY::Prompt.new
puts "\e[H\e[2J"
welcome = prompt.select("
                  ┬ ┬┌─┐┬  ┌─┐┌─┐┌┬┐┌─┐  ┌┬┐┌─┐  ┌┬┐┬ ┬┌─┐
                  │││├┤ │  │  │ ││││├┤    │ │ │   │ ├─┤├┤ 
                  └┴┘└─┘┴─┘└─┘└─┘┴ ┴└─┘   ┴ └─┘   ┴ ┴ ┴└─┘
 \n
 ██╗  ██╗ ██████╗ ██████╗       ██████╗       ██╗     ██╗███╗   ██╗███████╗
 ██║  ██║██╔═══██╗██╔══██╗      ██╔══██╗      ██║     ██║████╗  ██║██╔════╝
 ███████║██║   ██║██████╔╝█████╗██████╔╝█████╗██║     ██║██╔██╗ ██║█████╗  
 ██╔══██║██║   ██║██╔══██╗╚════╝██╔══██╗╚════╝██║     ██║██║╚██╗██║██╔══╝  
 ██║  ██║╚██████╔╝██████╔╝      ██████╔╝      ███████╗██║██║ ╚████║███████╗
 ╚═╝  ╚═╝ ╚═════╝ ╚═════╝       ╚═════╝       ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝
 \n
 ───────────────────────────────────────────────────────────────────────────
 \n                                                           
 Please select your role:") do |menu|
  menu.choice 'Mentor'
  menu.choice 'Mentee'
end

if welcome == 'Mentor'
  mentor_login
elsif welcome == 'Mentee'
  mentee_login
end

