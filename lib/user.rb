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
    end
end