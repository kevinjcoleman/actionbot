module BotInfo
  ISSUES_POSTBACK = { type: 'postback', title: 'Issues', payload: 'ISSUES' }
  CANDIDATE_POSTBACK = { type: 'postback', title: 'Candidate', payload: 'CANDIDATE' }
  NEWS_POSTBACK = {type: 'postback', title: 'News', payload: 'NEWS' }
  EVENT_POSTBACK = { type: 'postback', title: 'Go to an event', payload: 'EVENT' }
  VOLUNTEER_POSTBACK = { type: 'postback', title: 'Volunteer', payload: 'VOLUNTEER' }
  JOIN_POSTBACK = { type: 'postback', title: 'Join', payload: 'JOIN' }

  def bot
    @bot ||= PageBot.find_by(page_id: message.recipient['id'])
  end

  def sender
    @sender ||= Sender.find_by(facebook_id: message.sender['id'])
  end

  def missing_message
    giphy_url = ::Giphy.random('im sorry').image_original_url.to_s
    message.reply(text: "I'm sorry #{sender.first_name}, that looks like that\'s not setup yet.")
    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: giphy_url
        }
      }
    )
  end

  def welcome_message
    message.reply(text: "Hello #{sender.first_name}, my name is #{bot.name}. What would you like to do?")
    menu_quick_reply("To get started you can say, 'I'd like to take action' or 'I'd like to learn more', or simply hit one of the buttons below. Say 'help' or 'menu' to see this message again.")
  end

  def refresh_message
    message.reply(text: "Hey #{sender.first_name}, I'm a bot that's attached to the Facebook Page \"#{bot.name}\". How can I help?")
    menu_quick_reply("Message me something like 'I'd like to take action' or 'When is the next event?', or simply hit one of the buttons below to start exploring what you can do. Say 'help' or 'menu' to see this message again.")
  end

  def menu_quick_reply(text)
    message.reply(
      text: text,
        quick_replies: [
          {
            content_type: 'text',
            title: 'Learn more',
            payload: 'LEARN'
          },
          {
            content_type: 'text',
            title: 'Take action',
            payload: 'ACTION'
          }
        ]
      )
  end

  def action_message
    message.reply(action_message_params)
  end

  def action_message_params
    {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: "I'm so excited you'd like to participate #{sender.first_name}! 😃 How would you like to take action?",
          buttons: [
            EVENT_POSTBACK,
            VOLUNTEER_POSTBACK,
            JOIN_POSTBACK
          ]
        }
      }
    }
  end

  def learn_message
    message.reply(learn_message_params)
  end

  def learn_message_params
    {attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'What would you learn more about?',
        buttons: [
          ISSUES_POSTBACK,
          CANDIDATE_POSTBACK,
          NEWS_POSTBACK
        ]
      }
    }}
  end
end
