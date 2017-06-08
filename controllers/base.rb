# frozen_string_literal: true

require 'econfig'
require 'sinatra'
require 'json'
require 'rack-flash'
require 'rack/ssl-enforcer'
require 'rack/session/redis'
require 'slim/include'

# Base class for Totodile Web Application
class TotodileApp < Sinatra::Base
  extend Econfig::Shortcut

  enable :logging
  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)
  ONE_MONTH = 2_592_000 # ~ one month in seconds

  configure :production do
    use Rack::SslEnforcer
  end

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)

    SecureMessage.setup(settings.config)
    SecureSession.setup(settings.config)
  end

  # use Rack::Session::Cookie, expire_after: ONE_MONTH, secret: SecureSession.secret
  # use Rack::Session::Pool, expire_after: ONE_MONTH
  use Rack::Session::Redis, expire_after: ONE_MONTH, redis_server: settings.config.REDIS_URL

  use Rack::Flash

  def current_account?(params)
    @current_account && @current_account['name'] == params[:name]
  end

  def halt_if_incorrect_user(params)
    return true if current_account?(params)
    flash[:error] = 'You used the wrong account for this request'
    redirect '/auth/login'
    halt
  end

  before do
    @current_account = SecureSession.new(session).get(:current_account)
    @auth_token = SecureSession.new(session).get(:auth_token)
  end

  get '/' do
    @postings = GetAllPostingsWithoutToken.new(settings.config).call()

    slim :home
  end
end
