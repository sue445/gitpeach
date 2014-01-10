class SessionsController < ApplicationController
  def create
    api_response = Gitlab.session(params[:login], params[:password])
    user = User.find_or_create_by(gitlab_user_id: api_response.id) do |user|
      user.username      = api_response.username
      user.private_token = api_response.private_token
    end

    session[:user_id] = user.id
  end

  def destroy
  end
end
