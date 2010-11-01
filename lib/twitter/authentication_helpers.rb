module Twitter
  module AuthenticationHelpers
    def self.included(controller)
      controller.class_eval do
<<<<<<< HEAD
        helper_method :signed_in?, :username, :current_user
        hide_action :signed_in?, :username
=======
        helper_method :signed_in?
        hide_action :signed_in?
>>>>>>> 34123a1... added username to top of interface
      end
    end

    def signed_in?
      !session[:screen_name].nil?
    end

<<<<<<< HEAD
		def username
			session[:screen_name]
		end

		def current_user
			User.find_by_identifier(session[:identifier])
		end

=======
>>>>>>> 34123a1... added username to top of interface
    protected
      def authenticate
        deny_access unless signed_in?
      end

      def deny_access
        store_location
        render :template => "/sessions/new", :status => :unauthorized
      end

      def sign_in(profile)
        session[:screen_name] = profile.screen_name if profile
      end

      def redirect_back_or(default)
        session[:return_to] ||= params[:return_to]
        if session[:return_to]
          redirect_to(session[:return_to])
        else
          redirect_to(default)
        end
        session[:return_to] = nil
      end

      def store_location
        session[:return_to] = request.request_uri if request.get?
      end
  end
end