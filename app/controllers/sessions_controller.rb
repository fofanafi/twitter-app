class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:rpx_token] # RPX does not pass Rails form tokens

  def new
  end

	# user_data
	# found: {:name=>'John Doe', :username => 'john', :email=>'john@doe.com', :identifier=>'blug.google.com/openid/dsdfsdfs3f3'}
	# not found: nil (can happen with e.g. invalid tokens)
	def rpx_token
		if params[:token].blank?
			flash[:error] = "Not signed in with JanRain."
			redirect_to '/'
		else
			raise "hackers?" unless data = RPXNow.user_data(params[:token])
			User.find_by_identifier(data[:identifier]) || User.create!(data)
			session[:identifier] = data[:identifier]
			redirect_to '/'
		end
	end

  def create
    oauth.set_callback_url(finalize_session_url)

    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret

    redirect_to oauth.request_token.authorize_url
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  def finalize
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])

    profile = Twitter::Base.new(oauth).verify_credentials
    session['rtoken'] = session['rsecret'] = nil
    session[:atoken] = oauth.access_token.token
    session[:asecret] = oauth.access_token.secret

    sign_in(profile)
    redirect_back_or root_path
  end
end
