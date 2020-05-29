require 'pry'
class Mentor < ActiveRecord::Base
  extend User::ClassMethods
  include User::InstanceMethods
  has_many :pairings
  has_many :mentees, through: :pairings

  
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
      menu.choice 'See My Mentees'
      menu.choice 'Approve a Mentee'
      menu.choice 'Delete a Pairing'
      menu.choice 'Change My Hobby'
      menu.choice 'Log Out'
      menu.choice 'Exit'
    end
  
    if menu_option == 'See My Mentees'
      self.see_my_mentees(current_user)
    elsif menu_option == 'Approve a Mentee'
      clear_screen!
      self.approve_mentee(current_user)
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

  def self.approve_mentee(current_user)
    pending_pairings = current_user.pairings.where("status = 'Pending'")
    # binding.pry
    if pending_pairings == []
      puts "Sorry. You currently don't have any pending mentees."
      puts
      self.press_any(current_user)
    else
    puts "The following mentees are pending for your approval."
    puts
    pending_pairings_mentees = pending_pairings.map &:mentee
    puts pending_pairings_mentees
    puts
    puts "Enter the full name of the mentee you wish to approve, or 'exit'."
    puts
    print "Full Name: "
    approved_name = gets.chomp
    pending_pairings_mentees_names = pending_pairings_mentees.map  &:full_name
    if approved_name == "exit"
      self.user_menu(current_user)
    end 
    if pending_pairings_mentees_names.include?(approved_name) == false
      clear_screen!
      puts "Please enter one of the below names."
      puts
      self.approve_mentee(current_user)
    end 
    pairing_to_approve = pending_pairings.find do |pairing|
      pairing.mentor == current_user && pairing.mentee.full_name == approved_name
    end
    pairing_to_approve.status = "Approved"
    pairing_to_approve.save
    pairing_to_approve.reload
    current_user.save
    current_user.reload
    end
    clear_screen!
    bar = TTY::ProgressBar.new("Approving [:bar]", total: 30)
      30.times do
      sleep(0.05)
      bar.advance(1)
    end
    puts
    puts "Your pairing with #{approved_name} has been approved!"
    puts
    self.press_any(current_user)
  end 

  def self.see_my_mentees(current_user)
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
      puts "Sorry. You currently don't have any mentees."
      puts
    else
      puts "These are your mentees:"
      puts
      puts approved_pairings.map &:mentee
      puts
    end 
    self.press_any(current_user)
  end 
  
  def self.create_user 
    new_user = Mentor.new
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
      puts "Please enter a valid age."
      puts
      print "Age: "
      age = gets.chomp 
      age = age.to_i
    end 
    if age < 18 
      puts
      puts "You must be 18 years or older to be a mentor on this website."
      puts "Please come back in #{18 - age} years!"
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
    new_user.save
    puts
    puts "Press 'enter' to continue." 
    current_user = new_user
    clear_screen!
    puts "Welcome #{new_user.full_name}! Your account has been created." 
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
    if current_user.mentees == []
      puts "You don't have any pairings!"
      puts 
      self.press_any(current_user)
    end 
    puts current_user.mentees 
    puts 
    puts "Please enter the full name of the mentee to be removed, or type 'exit'"
    puts
    print "Full Name: "
    deleted_partner = gets.chomp
    if deleted_partner == "exit"
      self.user_menu(current_user)
    end 
    deleted_mentee = Mentee.all.select do |mentee|
      mentee.full_name == deleted_partner 
    end 
    if deleted_mentee == []
      clear_screen!
      puts "Sorry, please enter one of the names below."
      puts
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
    puts "You are no longer paired with #{ deleted_partner }."
    puts
    self.press_any(current_user)
  end
      
end