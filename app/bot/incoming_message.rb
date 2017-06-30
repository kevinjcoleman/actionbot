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
            EventResponder.new(message, bot).respond!
          when 'GET_STARTED_PAYLOAD'
            welcome_message
          else
            if message.payload.include?('EVENT-LEARN-')
              EventDetailsResponder.new(message, bot).respond!
            elsif message.payload.include?('RSVP-')
              EventRsvpResponder.new(message, bot).respond!
            else
              missing_message
            end
        end
      end
    end

    def welcome_message
      message.reply(
        text: "Hello #{username}, what would you like to do?",
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

    def username
      bot.graph.get_object(message.sender['id'])['first_name']
    end
  end
end
