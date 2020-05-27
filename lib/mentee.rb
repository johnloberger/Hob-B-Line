class Mentee < ActiveRecord::Base
    has_many :pairings
    has_many :mentors, through: :pairings

  def to_s
    "#{ full_name } loves to #{ favorite_hobby }"
  end

  def self.find_user(entered_name) 
    self.find_by(full_name: entered_name)
  end 

  def self.user_menu(current_user)
    clear_screen!
    puts "This is the menu."
    prompt = TTY::Prompt.new
    menu_option = prompt.select("This is the menu:") do |menu|
      menu.choice 'See My Mentors'
      menu.choice 'Create a Pairing'
      menu.choice 'Change My Hobby'
      menu.choice 'Exit'
    end

    if menu_option == 'See My Mentors'
      current_user.mentors 
      self.user_menu(current_user)
    elsif menu_option == 'Create a Pairing'
      #method needed here
      0
      self.user_menu(current_user)
    elsif menu_option == 'Change My Hobby'
      puts "Please enter your new favorite hobby."
      current_user.favorite_hobby = gets.chomp 
      puts "Your new favorite hobby is #{current_user.favorite_hobby}!"
      self.user_menu(current_user)
    else
      exit 
    end  
  end 

  def self.create_user 
    new_user = Mentee.new
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
    new_user.gender = gets.chomp 
    if new_user.age < 18
      puts
      puts "Please enter the name of a parent or guardian."
      print "Guardian name: "
      new_user.guardian_contact = gets.chomp
    end 
    new_user.save
    puts "Welcome #{new_user.full_name}!  Press any key to continue." 
    if gets.chomp != nil 
      self.user_menu
    end  
    self.user_menu(current_user)
  end 

  def self.mentee_login
    clear_screen!
    puts "Hello Mentee! Please enter your full name below!"
    puts
    puts
    print "Full Name: "
    
    entered_name = gets.chomp
    current_user = self.find_user(entered_name)
  
    clear_screen!
    if current_user
      self.user_menu(current_user)
    else
      self.create_user
    end
  end

end