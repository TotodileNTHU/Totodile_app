# frozen_string_literal: true

require 'http'

# Returns an authenticated user, or nil
class CreateVerifiedAccount
  def initialize(config)
    @config = config
  end

  def call(name:, email:, password:)
    response = HTTP.post("#{@config.API_URL}/accounts/",
                         json: { name: name,
                                 email: email,
                                 password: password })
    response.code == 201 ? true : false
  end
end
