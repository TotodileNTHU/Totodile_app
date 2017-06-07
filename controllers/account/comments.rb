require 'sinatra'

class TotodileApp < Sinatra::Base
  get '/postings/:posting_id/comments/?' do
    @posting_with_comments = GetAllComments.new(settings.config)
                              .call(posting_id: params['posting_id'])
         
    @posting_with_comments ? slim(:comments) : redirect('/')
  end

  post '/account/:name/comment/:posting_id/?' do
    if current_account?(params)
      CreateComment.new(settings.config).call(
        current_account: @current_account, content: params[:content], posting_id: params[:posting_id]
      )
      redirect '/postings/' + params[:posting_id] + '/comments/'
    end
  end
end
