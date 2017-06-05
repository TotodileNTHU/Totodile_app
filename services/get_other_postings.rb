require 'http'

# Returns all postings belonging to an account
class GetOtherPostings
  def initialize(config)
    @config = config
  end

  def call(current_account:, auth_token:, other_account_id:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{@config.API_URL}/accounts/#{other_account_id}/postings")
    
    response.code == 200 ? extract_postings(response.parse) : nil
  end

  private

  def extract_postings(postings)
    postings['data'].map do |posting|
      created_at = posting['attributes']['created_at'].split(' ')[0] + ' ' +posting['attributes']['created_at'].split(' ')[1]
      { id: posting['id'],
        owner_id: posting['relationships']['owner']['id'],
        owner_name: posting['relationships']['owner']['name'],
        content: posting['attributes']['content'],
        created_at: created_at }
    end
  end
end
