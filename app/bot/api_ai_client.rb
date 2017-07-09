class ApiAiClient
  attr_accessor :client

  def initialize
    @client = create_client
  end

  def create_client
    ApiAiRuby::Client.new(
      client_access_token: ENV["API_AI_CLIENT_TOKEN"]
    )
  end
end
