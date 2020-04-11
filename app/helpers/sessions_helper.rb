module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # これと同じ意味
    # @current_user || @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end
