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

#########################################
# How to test it:
# $ tux
#
# >> data = {username: 'fb_uid_1', password: '1234'}
# => {:username=>"fb_uid_1", :password=>"1234"}
# >> FindAuthenticatedAccount.call(data)
# {"type":"account","uid":"fb_uid_1","email":"cory@gmail.com","name":"cory"}
#
#########################################

# Returns an authenticated user, or nil
class FindAuthenticatedAccount
  def initialize(config)
    @config = config
  end

  def call(username:, password:)
    response = HTTP.post("#{@config.API_URL}/accounts/authenticate",
                         json: { username: username, password: password })
    response.code == 200 ? response.parse['account'] : nil
  end
end
