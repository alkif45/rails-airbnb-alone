class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :guest
  belongs_to :host
end
