class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :address, presence: true
  validates :price_per_night, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :number_of_bathrooms, :number_of_beds, :guests_limit, numericality: { only_integer: true }

  before_save :capitalize_title

  PROPERTY_TYPES = ["Apartment", "House", "Studio", "Villa", "Cabin"]

  def price_per_night_dollars
    price_per_night.to_f / 100
  end

  def price_per_night_dollars=(dollars)
    self.price_per_night = (dollars.to_f * 100).to_i
  end

  def overlapping_dates(start_date, end_date)
    return false unless available?

    flat.bookings.where.not(id: id).where(
      "start_date < ? AND end_date > ?", end_date, start_date
    ).none?
  end

  private

  def capitalize_title
    self.title = title.titleize
  end
end
