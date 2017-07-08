class EventResponder
  attr_accessor :message, :bot
  def initialize(message, bot)
    @message, @bot = message, bot
  end

  def respond!
    if bot.bot_events.any?
      respond_with_events
    else
      message.reply(text: "There aren't any events currently setup 😟")
    end
  end

  def respond_with_events
    message.reply(text: "Here's a list of events near you.")
    message.reply(
      attachment: {
          type: 'template',
          payload: {
            template_type:"generic",
            elements: event_elements
        }
      }
    )
  end

  def event_elements
    bot.bot_events.map { |event| event_element(event) }
  end

  def event_element(event)
    {
       title: event.name,
       image_url: event.picture_url,
       subtitle: "#{event.addresses.first.to_s}\n#{event.time_windows.first.start_at.strftime('%m/%d/%Y at %l %P')} to #{event.time_windows.first.end_at.strftime('%m/%d/%Y  at %l %P')}",
       default_action: {
         type: "web_url",
         url:"https://74b06bc4.ngrok.io",
         messenger_extensions: true,
         webview_height_ratio: "tall",
         fallback_url: "https://74b06bc4.ngrok.io"
       },
       buttons:[
         {
           type:"postback",
           title:"Learn more",
           payload:"EVENT-LEARN-#{event.id}"
         },{
           type:"postback",
           title:"RSVP",
           payload:"RSVP-#{event.id}"
         }
       ]
     }
  end
end
