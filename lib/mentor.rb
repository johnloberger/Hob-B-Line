class Mentor < ActiveRecord::Base
    has_many :pairings
    has_many :mentees, through: :pairings
end