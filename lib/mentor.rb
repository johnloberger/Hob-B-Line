class Mentor < ActiveRecord::Base
  extend User::ClassMethods
  include User::InstanceMethods
  has_many :pairings
  has_many :mentees, through: :pairings

  
  def self.user_menu(current_user)
    clear_screen!
    prompt = TTY::Prompt.new
    menu_option = prompt.select("
    Welcome #{ current_user.full_name }!
    \n
    Please select an option below:
    \n") do |menu|
      menu.choice 'See My Mentees'
      menu.choice 'Delete a Pairing'
      menu.choice 'Change My Hobby'
      menu.choice 'Exit'
    end
  
    if menu_option == 'See My Mentees'
      self.see_my_mentees(current_user)
    elsif menu_option == 'Delete a Pairing'
      self.delete_pairing(current_user)
    elsif menu_option == 'Change My Hobby'
      self.change_my_hobby(current_user)
    else
      clear_screen!
      puts "Goodbye #{current_user.full_name}!  Enjoy #{current_user.favorite_hobby}!"
      puts
      exit 
    end  
  end 

  def self.see_my_mentees(current_user)
    clear_screen!
    if current_user.mentees == []
      puts "Sorry. You currently don't have any mentees."
      puts
    else
      puts "These are your mentees:"
      puts
      puts current_user.mentees
      puts
    end 
    self.press_any(current_user)
  end 
  
  def self.create_user 
    new_user = Mentor.new
    puts "Enter your full name to begin."
    print "Full Name: "
    new_user.full_name = gets.chomp
    puts
    puts "Enter your age."
    print "Age: "
    age = gets.chomp
    age = age.to_i
    while Float === age || String === age || age < 18 do
      puts "Please enter a valid age. You must be 18 years or older to use this website."
      print "Age: "
      age = gets.chomp 
      age = age.to_i
    end 
    new_user.age = age
    puts
    puts "Enter your gender."
    print "Gender: "
    new_user.gender = gets.chomp
    puts
    puts "Enter your location."
    print "Location: "
    new_user.location = gets.chomp 
    puts
    puts "Enter your hobby."
    print "Hobby: "
    new_user.favorite_hobby = gets.chomp
    new_user.save
    puts "Press any key to continue." 
    current_user = new_user
    clear_screen!
    puts "Welcome #{ new_user.full_name }!"
    puts
    self.press_any(current_user)
  end 
    
  def self.mentor_login
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
    puts "Hello Mentor! Please enter your full name below!"
    puts
    puts
    print "Full Name: "
      
    entered_name = gets.chomp
    current_user = self.find_user(entered_name)
      
    while !current_user do
      clear_screen!
      puts "Please enter a valid name."
      puts
      print "Full Name: "
      entered_name = gets.chomp
      current_user = self.find_user(entered_name)
    end
    self.user_menu(current_user)
  end
    
  def self.delete_pairing(current_user)
    clear_screen!
    puts current_user.mentees 
    puts 
    puts "Please enter the full name of the mentee you would like to no longer be paired with or type 'exit' to return to the menu."
    puts
    print "Full Name: "
    deleted_partner = gets.chomp
    if deleted_partner == "exit"
      self.user_menu(current_user)
    end 
    deleted_mentee = Mentee.all.select do |mentee|
      mentee.full_name == deleted_partner 
    end 
    if deleted_mentee == nil
      clear_screen!
      puts "Sorry, please enter one of the names below."
      self.delete_pairing(current_user)
    end
    current_user.mentees -= deleted_mentee
    current_user.reload
    clear_screen!
    bar = TTY::ProgressBar.new("Deleting [:bar]", total: 30)
      30.times do
      sleep(0.05)
      bar.advance(1)
    end
    puts
    puts "You are no longer paired with #{ deleted_partner }. Please press enter to return to menu."
    puts
    self.press_any(current_user)
  end
      
end