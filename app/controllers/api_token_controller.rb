class ApiTokenController < ApplicationController

  # Validate the token
  def show
    # Eventually we want to expire tokens...
    token = ApiToken.find_by_token(token_edit_params[:token])
    head status: if token then 200 else 401 end
  end

  # Create a new token for a session
  def create
    if user = self.class.authenticate(token_create_params)
      @token = user.api_tokens.create
    else
      head status: 401
    end
  end

  # "Log out" by deleting the token
  def destroy
    ApiToken.find_by_token(token_destroy_params[:token]).destroy_all
  end

  private

  def token_create_params
    params.require(:user).permit(:email, :password)
  end

  def token_edit_params
    params.require(:api_token).permit(:token)
  end

  def self.authenticate(user_data)
    user = User.find_for_authentication(:email => user_data[:email])
    user.valid_password?(user_data[:password]) ? user : nil
  end
end
