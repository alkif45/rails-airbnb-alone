class ChangePricePerNightToIntegerInFlats < ActiveRecord::Migration[7.1]
  def up
    add_column :flats, :price_per_night_cents, :integer

    Flat.reset_column_information
    Flat.find_each do |flat|
      if flat.price_per_night.present?
        flat.update_column(:price_per_night_cents, (flat.price_per_night * 100).to_i)
      end
    end

    remove_column :flats, :price_per_night
    rename_column :flats, :price_per_night_cents, :price_per_night
  end

  def down
    add_column :flats, :price_per_night_float, :float

    Flat.reset_column_information
    Flat.find_each do |flat|
      if flat.price_per_night.present?
        flat.update_column(:price_per_night_float, flat.price_per_night / 100.0)
      end
    end

    remove_column :flats, :price_per_night
    rename_column :flats, :price_per_night_float, :price_per_night
  end
end
