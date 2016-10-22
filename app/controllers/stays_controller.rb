class StaysController < ApplicationController

  def index
    @stays = Stay.order(:created_at).all
  end

  def new
    @stay = Stay.new
  end

  def edit
    @stay = Stay.find(params[:id])
  end

  def create
    @stay = Stay.new(stay_params)

    if @stay.save
      redirect_to action: 'index', notice: 'Stay successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @stay = Stay.find(params[:id])
    if @stay.update(stay_params)
      redirect_to action: 'index', notice: 'Stay successfully updated.'
    else
      render action: 'edit'
    end
  end

private

  def stay_params
    params.require(:stay).permit(:user_id, :shelter_id, :check_in_date, :check_out_date)
  end

end
