class UsersController < ApplicationController

  def index

  end

  def new
    @user = User.new
    @cart = Cart.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(users_path, :notice => 'User was successfully created.')
    else
      render :action => :new
    end
  end

  def validate_username
    user = User.validate_username(params[:user][:username])
    render :inline => user == false ? "true" : "false"
  end

end
