module BotInfo
  def bot
    @bot ||= PageBot.find_by(page_id: message.recipient['id'])
  end

  def sender
    @sender ||= Sender.find_by(facebook_id: message.sender['id'])
  end
end
