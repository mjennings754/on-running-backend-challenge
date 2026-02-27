class Dealer < ActiveRecord::Base
    validates :name, :phone, :street, :city, :zipcode, :country, :latitude, :longitude, presence: true
end