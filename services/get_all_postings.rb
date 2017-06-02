require 'http'

# Returns all postings belonging to an account
class GetAllPostings
  def initialize(config)
    @config = config
  end

  def call(current_account:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{@config.API_URL}/postings")

    response.code == 200 ? extract_postings(response.parse) : nil
  end

  private

  def extract_postings(postings)
    postings['data'].map do |posting|
      { id: posting['id'],
        owner_id: posting['relationships']['owner']['id'],
        owner_name: posting['relationships']['owner']['name'],
        content: posting['attributes']['content'] }
    end
  end
end
