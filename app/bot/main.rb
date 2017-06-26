require 'facebook/messenger'#
include Facebook::Messenger#
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])#
puts 'the main file was loaded'

Bot.on :message do |message|
  BotMessaging::IncomingMessage.new(message).respond!
end

Bot.on :postback do |postback|
  BotMessaging::IncomingMessage.new(postback).respond!
end
