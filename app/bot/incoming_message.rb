include Facebook::Messenger

module BotMessaging
  class IncomingMessage
    include BotInfo

    attr_accessor :message
    def initialize(message)
      @message = message
      initialize_sender
    end

    def respond!
      message.typing_on
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
          ApiAiResponder.new(message: message).respond!
        end
      elsif message.is_a? Facebook::Messenger::Incoming::Postback
        puts message.payload
        case message.payload
          when 'EVENT'
            EventResponder.new(message).respond!
          when 'GET_STARTED_PAYLOAD'
            welcome_message
          else
            if /EVENT-LEARN/.match(message.payload)
              EventDetailsResponder.new(message, bot).respond!
            elsif /^RSVP-/.match(message.payload)
              EventRsvpResponder.new(message, bot).respond!
            elsif /CANCEL-RSVP-/.match(message.payload)
              EventRsvpCanceler.new(message).cancel!
            else
              missing_message
            end
        end
      elsif message.is_a? Facebook::Messenger::Incoming::Referral
        if /EVENT-[\d]+-REF-[\d]+/.match(message.ref)
          EventReferralResponder.new(message).respond!
        else
          missing_message
        end
      end
    end

    def initialize_sender
      if !sender
        Sender.create_from_facebook!(message.sender['id'], bot.graph.get_object(message.sender['id']))
      else
        sender.update_from_facebook!(Sender.initialized_params(bot.graph.get_object(message.sender['id'])))
      end
    end
  end
end
