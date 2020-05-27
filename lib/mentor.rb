class Mentor < ActiveRecord::Base
    has_many :pairings
    has_many :mentees, through: :pairings

    def to_s
      "#{ full_name }"
    end

    def self.press_any(current_user)
      puts "Press 'enter' to continue."  
          if gets.chomp != nil 
            self.user_menu(current_user)
          end  
    end

    def self.find_user(entered_name) 
      self.find_by(full_name: entered_name)
    end 
  
    def self.user_menu(current_user)
      clear_screen!
      prompt = TTY::Prompt.new
      menu_option = prompt.select("This is the menu:") do |menu|
        menu.choice 'See My Mentees'
        menu.choice 'Delete a Pairing'
        menu.choice 'Change My Hobby'
        menu.choice 'Exit'
      end
  
      if menu_option == 'See My Mentees'
        puts current_user.mentees
        self.press_any(current_user)
      elsif menu_option == 'Create a Pairing'
        #method needed here
        0
      elsif menu_option == 'Change My Hobby'
        puts "Please enter your new favorite hobby."
        current_user.favorite_hobby = gets.chomp 
        puts "Your new favorite hobby is #{current_user.favorite_hobby}!"
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
      new_user.gender = gets.chomp 
      puts
      puts "Enter your hobby."
      print "Hobby: "
      new_user.favorite_hobby = gets.chomp
      new_user.save
      puts "Welcome #{new_user.full_name}!  Press any key to continue." 
      if gets.chomp != nil 
        self.user_menu(current_user)
      end  
      self.user_menu(current_user)
    end 

    def self.mentor_login
      clear_screen!
      puts "Hello Mentor! Please enter your full name below!"
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