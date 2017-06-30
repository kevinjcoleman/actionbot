class PageAdditionService
  attr_accessor :user, :params, :bot
  def initialize(page_params: , user: )
    @user = user
    @params = page_params
  end

  def create_and_subscribe!
    create_bot
    subscribe_bot
    add_whitelisted_app_domain
    add_get_started_button
    add_default_persistent_menu
  end

  def create_bot
    @bot = user.page_bots.where(page_id: params[:page_id]).first_or_create do |bot|
      bot.name = params[:name]
      bot.access_token = params[:access_token]
      bot.save!
    end
  end

  def subscribe_bot
    Facebook::Messenger::Subscriptions.subscribe(access_token: bot.access_token)
  end

  def add_whitelisted_app_domain
    bot.add_whitelisted_domain(ENV["APP_DOMAIN"])
  end

  def add_get_started_button
    Facebook::Messenger::Profile.set({
      get_started: {
        payload: 'GET_STARTED_PAYLOAD'
      }
    }, access_token: bot.access_token)
  end

  def add_default_persistent_menu
    Facebook::Messenger::Profile.set({
      persistent_menu: [
        {
          locale: 'default',
          composer_input_disabled: false,
          call_to_actions: [
            {
              title: 'Learn more',
              type: 'nested',
              call_to_actions: [
                BotMessaging::IncomingMessage::ISSUES_POSTBACK,
                BotMessaging::IncomingMessage::CANDIDATE_POSTBACK,
                BotMessaging::IncomingMessage::NEWS_POSTBACK
              ]
            },
            {
              title: 'Take action!',
              type: 'nested',
              call_to_actions: [
                BotMessaging::IncomingMessage::EVENT_POSTBACK,
                BotMessaging::IncomingMessage::VOLUNTEER_POSTBACK,
                BotMessaging::IncomingMessage::DONATE_POSTBACK
              ]
            }
          ]
        }
      ]
    }, access_token: bot.access_token)
  end
end
