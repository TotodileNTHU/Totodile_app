# frozen_string_literal: true

require 'http'

# Returns an authenticated user, or nil
class CreateComment
  def initialize(config)
    @config = config
  end

  def call(current_account:, content:, posting_id:)
    response = HTTP.post("#{@config.API_URL}/accounts/#{current_account['id']}/postings/#{posting_id}/comments",
                         json: { content: content })
    response.code == 201 ? true : false
  end
end
