class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :guest_bookings, class_name: "Booking", foreign_key: "guest_id"
  has_many :host_bookings, class_name: "Booking", foreign_key: "host_id"
  has_one_attached :avatar

  def host?
    is_host
  end
end
