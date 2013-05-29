module SessionsHelper
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?()
    return !self.current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user

    if @current_user.nil?
      @current_user = User.find_by_remember_token(cookies[:remember_token])
    end

    return @current_user
  end

end