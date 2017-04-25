class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  private

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    counts @user
  end
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_tasks = user.tasks.count
  end
  
end