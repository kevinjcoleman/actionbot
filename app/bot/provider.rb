class Provider < Facebook::Messenger::Configuration::Providers::Base
  # Verify that the given verify token is valid.
  # verify_token - A String describing the application's verify token.
  # Returns a Boolean representing whether the verify token is valid.
  def valid_verify_token?(verify_token)
    ENV["VERIFY_TOKEN"] == verify_token
  end

  # Find the right application secret.
  # We'll just be using the one APP_SECRET for now unless it needs to be changed.
  def app_secret_for(page_id)
    ENV["APP_SECRET"]
  end

  # Find the right access token for the page
  # recipient - A Hash describing the `recipient` attribute of the message coming
  #             from Facebook.
  # Note: The naming of "recipient" can throw you off, but think of it from the
  # perspective of the message: The "recipient" is the page that receives the
  # message.
  # Returns a String describing an access token.
  def access_token_for(recipient)
    bot.find_by(page_id: recipient['id']).access_token
  end

  private

  def bot
    PageBot
  end
end

Facebook::Messenger.configure do |config|
  config.provider = Provider.new
end
