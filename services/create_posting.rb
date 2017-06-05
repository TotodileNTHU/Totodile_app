# frozen_string_literal: true

require 'http'

# Returns an authenticated user, or nil
class CreatePosting
  def initialize(config)
    @config = config
  end

  def call(current_account:, content:)
    response = HTTP.post("#{@config.API_URL}/accounts/#{current_account['id']}/owned_postings/",
                         json: { uid: current_account['name'],
                                 content: content })
    response.code == 201 ? true : false
  end
end
