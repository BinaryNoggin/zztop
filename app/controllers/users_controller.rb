class UsersController < ApplicationController

  def index
    if params[:user_id]
      @users = User.where(id: params[:user_id])
    else
      @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render action: 'index', notice: 'User successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User successfully updated.'
    else
      render action: 'edit'
    end
  end

private

  def set_user
    @user = User.includes(:columns, :records).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :ssn, :dob)
  end

end
