class Mentor < ActiveRecord::Base
    has_many :pairings
    has_many :mentees, through: :pairings

    def to_s
      "#{ full_name } loves to #{ favorite_hobby }"
    end

    def self.find_user(entered_name)
      self.find_by(full_name: entered_name)
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
        puts "you are in the system."
      else
        puts "Sorry, not in the system."
      end
    end

end