# frozen_string_literal: true

require 'sinatra'

# Account related routes
class TotodileApp < Sinatra::Base
  def authenticate_login(auth)
    @current_account = auth['account']
    @auth_token = auth['auth_token']
    current_session = SecureSession.new(session)
    current_session.set(:current_account, @current_account)
    current_session.set(:auth_token, @auth_token)
  end
  
  get '/account/login/?' do
    @postings = GetAllPostings.new(settings.config)
                                .call(current_account: @current_account,
                                      auth_token: @auth_token)
      
    slim :login
  end

  post '/account/login/?' do
    auth = FindAuthenticatedAccount.new(settings.config).call(
      name: params[:name], password: params[:password]
    )

    if auth
      authenticate_login(auth)
      flash[:notice] = "Welcome back #{@current_account['name']}"
      # @postings = GetAllPostings.new(settings.config)
      #                           .call(current_account: @current_account,
      #                                 auth_token: @auth_token)
      redirect '/'
    else
      flash[:error] = 'Your username or password did not match our records'
      slim :login
    end
  end

  get '/account/logout/?' do
    @current_account = nil
    SecureSession.new(session).delete(:current_account)
    flash[:notice] = 'You have logged out - please login again to use this site'
    slim :login
  end

  get '/account/register/?' do
    slim(:register)
  end

  get '/account/:name/?' do
    if @current_account && @current_account['name'] == params[:name]
      slim(:account)
    else
      redirect '/account/login'
    end
  end
end
