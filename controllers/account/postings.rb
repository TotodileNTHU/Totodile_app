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

  post '/account/:name/posting/?' do
  	if current_account?(params)
  	  CreatePosting.new(settings.config).call(
        current_account: @current_account, content: params[:content]
      )

      redirect '/account/' + @current_account['name'] + '/postings/'
    end
  end
end
