class EventRsvp < ApplicationRecord
  belongs_to :bot_event
  belongs_to :sender
end
