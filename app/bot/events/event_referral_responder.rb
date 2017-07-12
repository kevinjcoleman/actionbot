class EventReferralResponder
  include BotInfo
  include EventButtons

  attr_accessor :message, :event
  def initialize(message)
    @message = message
    @event = BotEvent.find(event_id)
  end

  def respond!
    if existing_rsvp?
      add_rsvp
      add_referral
    else

    end
    message.reply(attachment: {
                    type: 'template',
                    payload: {
                      template_type: 'button',
                      text: "Awesome #{sender.first_name}, I've recorded your RSVP to #{event.name}, we're looking forward to seeing you! 😀\nAt anytime you can see all your RSVPs by messaging 'RSVPS'.",
                      buttons: [share_button]
                    }
                  }
    )
  end

  def existing_rsvp?
    event.event_rsvps.where(sender_id: sender.id).any?
  end

  def add_rsvp
    event.event_rsvps.create(sender_id: sender.id)
  end

  def referrer
    @referrer ||= Sender.find_by(referral_id)
  end

  def event_id
    /EVENT-(\d+)-REF-[\d]+/.match(message.ref)[1].to_i
  end

  def referral_id
    /EVENT-[\d]+-REF-(\d+)/.match(message.ref)[1].to_i
  end
end
