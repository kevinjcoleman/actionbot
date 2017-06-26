include Facebook::Messenger

module BotMessaging
  class IncomingMessage
    ISSUES_POSTBACK = { type: 'postback', title: 'Issues', payload: 'ISSUES' }
    CANDIDATE_POSTBACK = { type: 'postback', title: 'Candidate', payload: 'CANDIDATE' }
    NEWS_POSTBACK = {type: 'postback', title: 'News', payload: 'NEWS' }
    EVENT_POSTBACK = { type: 'postback', title: 'Go to an event', payload: 'EVENT' }
    VOLUNTEER_POSTBACK = { type: 'postback', title: 'Volunteer', payload: 'VOLUNTEER' }
    DONATE_POSTBACK = { type: 'postback', title: 'Donate', payload: 'DONATE' }

    attr_accessor :message
    def initialize(message)
      @message = message
    end

    def respond!
      puts message.inspect
      puts "this is the bot #{bot}"
      if message.is_a? Facebook::Messenger::Incoming::Message
        if message.quick_reply
          case message.quick_reply
            when 'LEARN'
              learn_message
            when 'ACTION'
              action_message
            else
          end
        else
          if /get started/.match(message.text)
            welcome_message
          end
        end
      elsif message.is_a? Facebook::Messenger::Incoming::Postback
        puts message.payload
        case message.payload
          when 'EVENT'
            event_loader
          when 'GET_STARTED_PAYLOAD'
            welcome_message
          else
            missing_message
        end
      end
    end

    def welcome_message
      message.reply(
        text: 'What would you like to do?',
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
      message.reply(
        attachment: {
          type: 'template',
          payload: {
            template_type: 'button',
            text: 'How would you like to take action?',
            buttons: [
              EVENT_POSTBACK,
              VOLUNTEER_POSTBACK,
              DONATE_POSTBACK
            ]
          }
        }
      )
    end

    def learn_message
      message.reply(
        attachment: {
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
        }
      )
    end

    def missing_message
      giphy_url = ::Giphy.random.image_original_url.to_s
      message.reply(text: 'It looks like that\'s not setup yet.')
      message.reply(
        attachment: {
          type: 'image',
          payload: {
            url: giphy_url
          }
        }
      )
    end
    def bot
      @bot ||= PageBot.find_by(page_id: message.recipient['id'])
    end

    def event_loader
      Facebook::Messenger::Profile.set({
        persistent_menu: [
          {
            locale: 'default',
            composer_input_disabled: true,
            call_to_actions: [
              {
                title: 'Learn more',
                type: 'nested',
                call_to_actions: [
                  ISSUES_POSTBACK,
                  CANDIDATE_POSTBACK,
                  NEWS_POSTBACK
                ]
              },
              {
                title: 'Take action!',
                type: 'nested',
                call_to_actions: [
                  EVENT_POSTBACK,
                  VOLUNTEER_POSTBACK,
                  DONATE_POSTBACK
                ]
              }
            ]
          }
        ]
      }, access_token: bot.access_token)
    end
  end
end
