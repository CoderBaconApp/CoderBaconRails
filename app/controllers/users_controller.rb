class UsersController < ApplicationController
  def index
    @users = User.all.where.not(id: current_user)
  end

  def show
    @user = User.friendly.find(params[:id])
  end
end