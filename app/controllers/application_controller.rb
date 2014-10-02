class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in? #by defining these two controller methods available in all controller actions and view template.

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    #this code will return nil rather than throwing an exception. 
    #'||=' memoization technique is a minor performance optimization.
    #if @current_user exist, do not run the code after '||=' else do so, ensuring we will hit database once. 
  end

  def logged_in?
    !!current_user #turns any object into a boolean value
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end

end
