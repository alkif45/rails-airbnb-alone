class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :require_host, only: %i[new create]

  def index
    @flats = Flat.all
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to @flat
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :address, :description, :price_per_night_dollars, :number_of_bathrooms, :number_of_beds,
                                 :guests_limit, :property_type, :available)
  end

  def require_host
    unless current_user.host?
      redirect_to root_path, alert: "Only hosts can create flats."
    end
  end
end
