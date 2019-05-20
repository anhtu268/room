class Reservation < ApplicationRecord
  include ReservationDecorator
  has_many :reservation_details, dependent: :destroy
  has_many :rooms, through: :reservation_details
  belongs_to :user
end
