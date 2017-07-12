module EventButtons
  def share_button
    {
      type: "element_share",
      share_contents: {
       attachment: {
         type: 'template',
         payload: {
           template_type: 'generic',
           elements: [
             {
               title: "Would you join me at #{event.name}?",
               subtitle: "#{event.address.to_s}\n#{event.time_window.start_at.strftime('%m/%d/%Y at %l %P')} to #{event.time_window.end_at.strftime('%m/%d/%Y  at %l %P')}",
               image_url: event.picture_url,
               default_action: {
                 type: "web_url",
                 url: event_referal_url
               },
               buttons: [
                 {
                   type: "web_url",
                   url: event_referal_url,
                   title: "Join #{sender.first_name} at #{event.name}"
                 }
               ]
             }
           ]
         }
        }
      }
    }
  end

  def event_referal_url
    "https://m.me/#{event.page_bot.page_id}?ref=EVENT-#{event.id}-REF-#{sender.facebook_id}"
  end
end
