class PageAdditionService
  attr_accessor :user, :params, :bot
  def initialize(page_params: , user: )
    @user = user
    @params = page_params
  end

  def create_and_subscribe!
    @bot = user.page_bots.where(page_id: params[:page_id]).first_or_create do |bot|
      bot.name = params[:name]
      bot.access_token = params[:access_token]
      bot.save!
    end
    Facebook::Messenger::Subscriptions.subscribe(access_token: bot.access_token)
    Facebook::Messenger::Profile.set({
      get_started: {
        payload: 'GET_STARTED_PAYLOAD'
      }
    }, access_token: bot.access_token)
  end
end
