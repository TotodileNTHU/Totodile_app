require 'http'

# Returns all comments
class GetAllComments
  def initialize(config)
    @config = config
  end

  def call(current_account:, auth_token:, posting_id:)
    puts 'comment service'
    puts posting_id
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{@config.API_URL}/postings/1/comments/")
    puts response.parse
    response.code == 200 ? extract_comments(response.parse) : nil
  end

  private

  def extract_comments(comments)
    puts comments
  end
end
