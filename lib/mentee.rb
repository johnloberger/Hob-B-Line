class Mentee < ActiveRecord::Base
    extend User::ClassMethods
    include User::InstanceMethods
    has_many :pairings
    has_many :mentors, through: :pairings
    
    
  def self.create_pairing(current_user) 
    my_compatible_mentors = self.find_compatible_mentors(current_user)
    if my_compatible_mentors == []
      pastel = Pastel.new
      puts pastel.bright_red("Sorry! There are currently no mentors with the hobby: #{current_user.favorite_hobby}.")
      puts
      self.press_any(current_user)
    end
    my_compatible_mentors_names = my_compatible_mentors.map &:full_name
    puts "These mentors have the same favorite hobby as you:"
    puts
    puts my_compatible_mentors 
    puts "Please enter the full name of the mentor you would like to be paired with or type 'exit'"
    puts
    print "Full Name: "
    mentor_choice = gets.chomp
    if mentor_choice == "exit"
      self.user_menu(current_user)
    end 
    if my_compatible_mentors_names.include?(mentor_choice) == false
      clear_screen!
      pastel = Pastel.new
      puts pastel.bright_red("Please enter one of the below names.")
      puts
      self.create_pairing(current_user)
    end 
    pairing_mentor = my_compatible_mentors.find do |mentor|
      mentor.full_name == mentor_choice
    end 
    current_user.mentors << pairing_mentor
    new_pairing = Pairing.last
    new_pairing.status = "Pending"
    new_pairing.save
    new_pairing.reload
    clear_screen!
    bar = TTY::ProgressBar.new("Submitting Pairing [:bar]", total: 30)
      30.times do
      sleep(0.05)
      bar.advance(1)
    end
    puts
    pastel = Pastel.new
    puts pastel.bright_green("Congratulations! Your pairing with #{mentor_choice} is now pending!")
    puts
    current_user.reload
    self.press_any(current_user)
  end 
  
  def self.find_compatible_mentors(current_user)
    Mentor.all.select do |mentor|
        mentor.favorite_hobby == current_user.favorite_hobby && current_user.mentor_ids.include?(mentor.id) == false 
    end 
  end 
  
  def self.user_menu(current_user)
    clear_screen!
    prompt = TTY::Prompt.new
    menu_option = prompt.select("
    You are logged in as: #{ current_user.full_name }
    \n
    ███    ███     ███████     ███    ██     ██    ██ 
    ████  ████     ██          ████   ██     ██    ██ 
    ██ ████ ██     █████       ██ ██  ██     ██    ██ 
    ██  ██  ██     ██          ██  ██ ██     ██    ██ 
    ██      ██     ███████     ██   ████      ██████ 
    \n
    Please select an option below:
    \n") do |menu|
      menu.choice 'See Mentors'
      menu.choice 'Create a Pairing'
      menu.choice 'Delete a Pairing'
      menu.choice 'Change My Hobby'
      menu.choice 'Log Out'
      menu.choice 'Exit'
    end

    if menu_option == 'See Mentors'
      self.see_mentors(current_user)
    elsif menu_option == 'Create a Pairing'
      clear_screen!
      create_pairing(current_user)
    elsif menu_option == 'Delete a Pairing'
      clear_screen!
      self.delete_pairing(current_user)
    elsif menu_option == 'Change My Hobby'
      self.change_my_hobby(current_user)
    elsif menu_option == 'Log Out'
      main_menu
    else
      clear_screen!
      puts "Goodbye #{current_user.full_name}!  Enjoy #{current_user.favorite_hobby}!"
      puts
      exit 
    end  
  end 

  def self.see_mentors(current_user)
    clear_screen!
    prompt = TTY::Prompt.new
    see_mentors = prompt.select("Please select an option below.
    \n") do |menu|
    menu.choice 'See My Mentors'
    menu.choice 'See My Pending Mentors'
  end

    if see_mentors == 'See My Mentors'
      self.see_my_mentors(current_user)
    elsif see_mentors == 'See My Pending Mentors'
      self.see_pending_mentors(current_user)
    end
  end 

  def self.see_pending_mentors(current_user)
    clear_screen!
    puts
    puts
    puts
    spinner = TTY::Spinner.new("           Loading :spinner  ", format: :dots)
      spinner.auto_spin 
      sleep(1)
      spinner.stop('Done!')
      clear_screen!
    pending_pairings = current_user.pairings.where("status = 'Pending'")
    if pending_pairings == []
      puts "You don't have any pending mentors."
      puts
    else
      puts "These are your pending mentors:"
      puts
      puts pending_pairings.map &:mentor
    end 
    self.press_any(current_user)
  end 

  def self.see_my_mentors(current_user)
    clear_screen!
    puts
    puts
    puts
    spinner = TTY::Spinner.new("           Loading :spinner  ", format: :dots)
      spinner.auto_spin 
      sleep(1)
      spinner.stop('Done!')
      clear_screen!
    approved_pairings = current_user.pairings.where("status = 'Approved'")
    if approved_pairings == []
      puts "Sorry. You currently don't have any mentors."
      puts
    else
      puts "These are your approved mentors:"
      puts
      puts approved_pairings.map &:mentor
    end 
    self.press_any(current_user)
  end 
  
  def self.create_user 
    new_user = Mentee.new
    puts "Enter your full name to begin."
    puts
    print "Full Name: "
    new_user.full_name = gets.chomp
    puts
    puts "Enter your age."
    puts
    print "Age: "
    age = gets.chomp
    age = age.to_i
    while Float === age || String === age || age < 1 do
      puts
      pastel = Pastel.new
      puts pastel.bright_red("Please enter a valid age.")
      puts
      print "Age: "
      age = gets.chomp 
      age = age.to_i
    end 
    if age < 10
      puts
      pastel = Pastel.new
      puts pastel.bright_red("You must be 10 years or older to be a mentee on this website.")
      puts "Please come back in #{10 - age} years!"
      puts
      exit 
    end 
    new_user.age = age
    puts
    puts "Enter your gender."
    puts
    print "Gender: "
    new_user.gender = gets.chomp
    puts
    puts "Enter your location."
    puts
    print "Location: "
    new_user.location = gets.chomp 
    puts
    puts "Enter your hobby."
    puts
    print "Hobby: "
    new_user.favorite_hobby = gets.chomp
    if new_user.age < 18
      puts
      puts "Please enter the name of a parent or guardian."
      puts
      print "Guardian name: "
      new_user.guardian_contact = gets.chomp
    end 
    new_user.save
    pastel = Pastel.new
    puts pastel.bright_green("Welcome #{new_user.full_name}! Your account has been created.") 
    puts
    current_user = new_user
    self.press_any(current_user)
  end 

  def self.mentee_login
    clear_screen!
    prompt = TTY::Prompt.new
    login_menu = prompt.select("Please log-in below or create a new account.
    \n") do |menu|
    menu.choice 'Log-In'
    menu.choice 'Create Account'
  end

    if login_menu == 'Log-In'
      self.user_login
    elsif login_menu == 'Create Account'
      clear_screen!
      self.create_user
    end
  end

  def self.user_login
    clear_screen!
    puts "Hello Mentee! Please enter your full name below!"
    puts
    puts
    print "Full Name: "
      
    entered_name = gets.chomp
    current_user = self.find_user(entered_name)
      
    while !current_user do
      clear_screen!
      pastel = Pastel.new
      puts pastel.bright_red("Please enter a valid name.")
      puts
      print "Full Name: "
      entered_name = gets.chomp
      current_user = self.find_user(entered_name)
    end
    self.user_menu(current_user)
  end

  def self.delete_pairing(current_user)
    if current_user.mentors == []
      puts "You don't have any pairings!"
      puts 
      self.press_any(current_user)
    end 
    puts current_user.mentors 
    puts 
    puts "Please enter the full name of the mentee to be removed, or type 'exit'"
    puts
    print "Full Name: "
    deleted_partner = gets.chomp
    if deleted_partner == "exit"
      self.user_menu(current_user)
    end 
    deleted_mentor = Mentor.all.select do |mentor|
      mentor.full_name == deleted_partner 
    end 
    if deleted_mentor == []
      clear_screen!
      pastel = Pastel.new
      puts pastel.bright_red("Sorry, please enter one of the names below.")
      puts
      self.delete_pairing(current_user)
    end
    current_user.mentors -= deleted_mentor
    current_user.reload
    clear_screen!
    bar = TTY::ProgressBar.new("Deleting [:bar]", total: 30)
      30.times do
      sleep(0.05)
      bar.advance(1)
    end
    puts
    pastel = Pastel.new
    puts pastel.bright_green("You are no longer paired with #{ deleted_partner }.")
    puts
    self.press_any(current_user)
  end

end