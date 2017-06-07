require 'http'

# Returns all comments
class GetAllComments
  def initialize(config)
    @config = config
  end

  def call(posting_id:)
    posting_info = HTTP.get("#{@config.API_URL}/postings/#{posting_id}")
    response = HTTP.get("#{@config.API_URL}/postings/#{posting_id}/comments/")
    response.code == 200 ? extract_comments(posting_info.parse, response.parse) : nil
  end

  private

  def extract_comments(posting, comments)
    comment_list = comments['data'].map do |comment|
      created_at = comment['attributes']['created_at'].split(' ')[0] + ' ' + comment['attributes']['created_at'].split(' ')[1]
      { id: comment['id'],
        commenter_id: comment['attributes']['commenter_id'],
        commenter_name: comment['attributes']['commenter_name'],
        content: comment['attributes']['content'],
        created_at: created_at,
      }
    end
    created_at = posting['attributes']['created_at'].split(' ')[0] + ' ' + posting['attributes']['created_at'].split(' ')[1]
    result = {
      id: posting['id'],
      owner_id: posting['relationships']['owner']['id'],
      owner_name: posting['relationships']['owner']['name'],
      content: posting['attributes']['content'],
      created_at: created_at,
      comments: comment_list
    }
  end
end
