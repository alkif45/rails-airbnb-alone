class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :guest, class_name: "User"

  validates :start_date, :end_date, presence: true
  validates :number_of_guests, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 50 }
  validate :end_date_after_start_date
  validate :overlapping_dates

  def overlapping_dates
    return unless flat

    overlapping = flat.bookings.where.not(id: id).where(
      "start_date < ? AND end_date > ?", end_date, start_date
    )

    if overlapping.exists?
      add.errors(:base, "The dates are overlapping.")
    end
  end

  def duration
    (end_date - start_date).to_i
  end

  def calculate_total_price
    self.total_price = duration * flat.price_per_night
  end

  private

  def end_date_after_start_date
    return if end_date > start_date

    errors.add(:end_date, "the date must be after the start date")
  end
end
