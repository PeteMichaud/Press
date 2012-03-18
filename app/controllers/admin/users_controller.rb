class Admin::UsersController < ApplicationController

  layout 'admin'

  # LIST
  def index
    @users = User.order('created_at ASC')
  end

  # NEW
  def new
    @user = User.new
  end

  # CREATE
  def create
    @user = User.new params[:user]
    @user.salt ||= '123456' # @TODO Temporary user salt
    if @user.save
      flash[:success] = 'User Created.'
      redirect_to :action => 'index'
    else
      render 'new'
    end
  end


end
