require 'sinatra'

class TotodileApp < Sinatra::Base
  get '/account/:name/postings/?' do
    if current_account?(params)
      @postings = GetUserPostings.new(settings.config)
                                .call(current_account: @current_account,
                                      auth_token: @auth_token)
    end
    
    @postings ? slim(:postings_all) : redirect('/')
  end
end
