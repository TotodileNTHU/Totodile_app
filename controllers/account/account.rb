# frozen_string_literal: true

require 'sinatra'

# Account related routes
class TotodileApp < Sinatra::Base
  get '/account/login/?' do
    slim :login
  end

  post '/account/login/?' do
    result = FindAuthenticatedAccount.call(
      {username: params[:username], password: params[:password]}.to_json
    )

    if result.success?
      @current_account = result.value
      session[:current_account] = @current_account
      flash[:error] = "Welcome back #{@current_account['uid']}"
      slim :home
    else
      flash[:error] = 'Your username or password did not match our records'
      slim :login
    end
  end

  get '/account/logout/?' do
    @current_account = nil
    session[:current_account] = nil
    flash[:notice] = 'You have logged out - please login again to use this site'
    slim :login
  end

  get '/account/register/?' do
    slim(:register)
  end

  get '/account/:username/?' do
    if @current_account && @current_account['username'] == params[:username]
      slim(:account)
    else
      redirect '/account/login'
    end
  end
end
