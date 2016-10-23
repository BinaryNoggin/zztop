class UsersController < ApplicationController

  def index
    @users = User.order(:last_name, :first_name).all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    cocs_with_services = Coc.find_for_user(@user)
    @services = cocs_with_services.map {|h| "#{h[:name]}: #{h[:services].map(&:to_s).join(', ')}"}
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to action: 'index', notice: 'User successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to action: 'index', notice: 'User successfully updated.'
    else
      render action: 'edit'
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :ssn, :dob, :phone_number)
  end

end
