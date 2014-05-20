class UsersController < ApplicationController
  protect_from_forgery except: :api_token

  def index
    @users = User.all.where.not(id: current_user)
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def api_token
    if user = self.class.authenticate(api_token_params)
      @token = user.api_tokens.create
    else
      head status: 401
    end
  end
end
