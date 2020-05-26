class Mentee < ActiveRecord::Base
    has_many :pairings
    has_many :mentors, through :pairings
end