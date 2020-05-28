module User 
    module InstanceMethods
        def to_s
            "Full name: #{ full_name }
            Age: #{age}
            Gender: #{gender}
            Favorite Hobby: #{favorite_hobby}
            Location: #{location}"
        end
    end

    module ClassMethods
        def press_any(current_user)
            puts "Press 'enter' to continue."  
                if gets.chomp != nil 
                    self.user_menu(current_user)
                end      
        end
    
        def find_user(entered_name) 
            self.find_by(full_name: entered_name)
        end 

        def change_my_hobby(current_user)
            clear_screen!
            puts "This is your current favorite hobby: #{current_user.favorite_hobby}"
            puts 
            puts "Please enter your new favorite hobby or type 'exit' to return to the menu."
            puts
            print "Favorite Hobby: "
            hobby = gets.chomp
            if hobby == "exit"
              self.user_menu(current_user)
            end 
            current_user.favorite_hobby = hobby 
            current_user.save
            current_user.reload
            puts
            puts "Your new favorite hobby is #{current_user.favorite_hobby}! Please press enter to return to menu."
            puts
            press_any(current_user)
          end 
    end
end