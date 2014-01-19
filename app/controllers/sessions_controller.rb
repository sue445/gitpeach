class SessionsController < ApplicationController
  def create
    api_response = Gitlab.session(params[:login], params[:password])
    user = User.find_or_create_by(gitlab_user_id: api_response.id)

    user.username      = api_response.username
    user.private_token = api_response.private_token
    user.email         = api_response.email
    user.save!

    session[:user_id] = user.id

    back_to_path = params[:back_to] ? params[:back_to] : root_path
    redirect_to back_to_path, notice: "Signed in!"

  rescue Gitlab::Error::Unauthorized => e
    redirect_to root_path(back_to: params[:back_to]), alert: "Unauthorized"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed Out!"
  end
end
