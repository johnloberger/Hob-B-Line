class Mentor < ActiveRecord::Base
    has_many :pairings
    has_many :mentees, through: :pairings

    def to_s
      "#{ full_name } loves to #{ favorite_hobby }"
    end

end