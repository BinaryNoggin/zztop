class SheltersController < ApplicationController

  def index
    @shelters = Shelter.order(:name).all
  end

  def new
    @shelter = Shelter.new
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.new(shelter_params)

    if @shelter.save
      redirect_to action: 'index', notice: 'Shelter successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @shelter = Shelter.find(params[:id])
    if @shelter.update(shelter_params)
      redirect_to action: 'index', notice: 'Shelter successfully updated.'
    else
      render action: 'edit'
    end
  end

private

  def shelter_params
    params.require(:shelter).permit(:name, :address, :description)
  end

end
