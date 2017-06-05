require 'sinatra'

class TotodileApp < Sinatra::Base
  get '/postings/:posting_id/comments/?' do
  	puts 'comment controller'
    if current_account?(params)
      @commetns = GetAllComments.new(settings.config)
                                .call(current_account: @current_account,
                                      auth_token: @auth_token,
                                      posting_id: params['posting_id'])
    end

    
    # @commetns ? slim(:postings_all) : redirect('/')
  end
end
