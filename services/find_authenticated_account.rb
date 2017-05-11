# frozen_string_literal: true

# require 'http'

# # Returns an authenticated user, or nil
# class FindAuthenticatedAccount
#   def initialize(config)
#     @config = config
#   end

#   def call(username:, password:)
#     response = HTTP.post("#{@config.API_URL}/accounts/authenticate",
#                          json: { uid: username, password: password })
#     response.code == 200 ? response.parse['account'] : nil
#   end
# end

require 'http'

class FindAuthenticatedAccount
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin
  def self.call(input)
    Dry.Transaction(container: self) do
      step :validate_input
      step :call_api_to_authenticate
    end.call(input)
  end

  register :validate_input, lambda { |input|
    begin
      data = {uid: input[:username], password: input[:password]}
      Right(data)
    rescue
      Left(Error.new('Wrong input account data'))
    end
  }

  register :call_api_to_authenticate, lambda { |data|
    response = HTTP.post("#{TotodileApp.config.API_URL}/accounts/authenticate", json: data)
    
    if response.status == 200
      Right(response.body)
    else
      Left(Error.new('Wrong username/password')) 
    end
  }
end
