require 'http'

# Returns all postings
class GetAllPostingsWithoutToken
  def initialize(config)
    @config = config
  end

  def call()
    response = HTTP.get("#{@config.API_URL}/postings_test")
    
    response.code == 200 ? extract_postings(response.parse) : nil
  end

  private

  def extract_postings(postings)
    postings['data'].map do |posting|
      created_at = posting['attributes']['created_at'].split(' ')[0] + ' ' + posting['attributes']['created_at'].split(' ')[1]
      { id: posting['id'],
        owner_id: posting['relationships']['owner']['id'],
        owner_name: posting['relationships']['owner']['name'],
        content: posting['attributes']['content'],
        created_at: created_at }
    end
  end
end
