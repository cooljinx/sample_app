module SessionsHelper
  
  def sign_in(user)
      cookies.permanent.signed[:remember_token] = [user.id, user.salt]
      current_user = user
  end
  
  def current_user=(user)   # method assigning user to current_user
      @current_user = user
  end
  
  def current_user
      @current_user ||= user_from_remember_token  # short-circuit evaluation, current_user is assigned from token only first time
  end
  
  def signed_in?
    !current_user.nil?     # returns true if user is signed in
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end
  
  def authenticate    # used by Users controller and Microposts controller
    deny_access unless signed_in?
  end
  
  def deny_access
    store_location          # for friendly forwarding
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
  
      def user_from_remember_token
          User.authenticate_with_salt(*remember_token) # ' * ' to use a two member array/hash as a method argument
      end
      
      def remember_token
          cookies.signed[:remember_token] || [nil, nil]   # returns nil if cookies.signed[:remember_token] is itself nil
      end
      
      def store_location
        session[:return_to] = request.fullpath
      end

      def clear_return_to
        session[:return_to] = nil
      end
        
end
