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
      puts current_user.mentees
      self.press_any(current_user)
    elsif menu_option == 'Delete a Pairing'
      self.delete_pairing(current_user)
    elsif menu_option == 'Change My Hobby'
      puts "Please enter your new favorite hobby."
      puts
      print "Favorite Hobby: "
      current_user.favorite_hobby = gets.chomp 
      current_user.save
      current_user.reload
      puts "Your new favorite hobby is #{current_user.favorite_hobby}! Please press enter to return to menu."
      self.press_any(current_user)
    else
      exit 
    end  
  end 
  
  def self.create_user 
    new_user = Mentor.new
    puts "Enter your full name to begin."
    print "Full Name: "
    new_user.full_name = gets.chomp
    puts
    puts "Enter your age."
    print "Age: "
    new_user.age = gets.chomp
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
    self.press_any(current_user)
  end 
    
  def self.mentor_login
    clear_screen!
    prompt = TTY::Prompt.new
    login_menu = prompt.select("Please log-in below or create a new account.") do |menu|
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
    puts current_user.mentees 
    puts 
    puts "Please enter the full name of the mentee you would like to no longer be paired with."
    puts
    print "Full Name: "
    deleted_partner = gets.chomp
    pairing_to_delete = Pairing.all.find do |pairing|
    pairing.mentor == current_user && pairing.mentee.full_name == deleted_partner
    end
    if pairing_to_delete == nil
      clear_screen!
      puts "Sorry, please enter one of the names below."
      self.delete_pairing(current_user)
    end
    Pairing.destroy(pairing_to_delete.id)
    current_user.reload
    clear_screen!
    puts "You are no longer paired with #{ deleted_partner }. Please press enter to return to menu."
    self.press_any(current_user)
  end
    
    
end