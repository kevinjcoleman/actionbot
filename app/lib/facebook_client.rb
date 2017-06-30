class FacebookClient
  attr_accessor :options, :endpoint
  include HTTParty
  base_uri "https://graph.facebook.com"

  def initialize(bot, endpoint)
    @options = {access_token: bot.access_token}
    @endpoint = "/v2.6/me/#{endpoint}"
  end

  def post(params)
    self.class.post(endpoint, query: options.merge(params))
  end

  def get(params)
    self.class.get(endpoint, query: options.merge(params))
  end
end
