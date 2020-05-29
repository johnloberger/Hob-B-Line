require_relative '../config/environment'

# DEFINED METHODS
def clear_screen!
  puts "\e[H\e[2J"
end

def main_menu
prompt = TTY::Prompt.new
clear_screen!
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
  menu.choice "┌──────┐
  │Mentor│
  └──────┘"
  menu.choice "┌──────┐
  │Mentee│
  └──────┘"
end

if welcome == "┌──────┐
  │Mentor│
  └──────┘"
  Mentor.mentor_login
elsif welcome == "┌──────┐
  │Mentee│
  └──────┘"
  Mentee.mentee_login
end
end 

main_menu







