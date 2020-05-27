require_relative '../config/environment'
require 'pry'

# DEFINED METHODS
def clear_screen!
  puts "\e[H\e[2J"
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
  Mentor.mentor_login
elsif welcome == 'Mentee'
  Mentee.mentee_login
end


# prompt = TTY::Prompt.new
# puts "\e[H\e[2J"
# menu = prompt.select("Welcome #{ entered_name }! Select one of the following menu options.") do |menu|
# menu.choice 'View Pairings'
# menu.choice 'Update Profile'


# if menu == 'View Pairings'
#   Pairing.all.map {|p| p.mentor.full_name == entered_name}
# end






