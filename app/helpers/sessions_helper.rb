module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    if session[:user_id]
      if @current_user
        @current_user = User.find_by(id: params[:user_id])
      else
        @current_user
      end
    end
  end
end
