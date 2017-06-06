require 'sinatra'

class TotodileApp < Sinatra::Base
  get '/postings/:posting_id/comments/?' do
  	puts 'comment controller'
    if current_account?(params)
      @posting_with_comments = GetAllComments.new(settings.config)
                                .call(current_account: @current_account,
                                      auth_token: @auth_token,
                                      posting_id: params['posting_id'])
      puts @posting_with_comments
    end

    
    @posting_with_comments ? slim(:comments) : redirect('/')
  end
end
