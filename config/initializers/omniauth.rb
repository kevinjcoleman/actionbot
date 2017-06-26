OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["APP_ID"], ENV["APP_SECRET"], scope: 'public_profile, pages_messaging, pages_messaging_subscriptions, manage_pages, pages_show_list', info_fields: 'id,name,link'
end
