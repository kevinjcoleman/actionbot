class BotEvent < ApplicationRecord
  belongs_to :page_bot
  has_many :addresses, as: :addressable
  has_many :time_windows, as: :timeable
  has_many :event_rsvps

  def self.params
    [:name, :description, :picture_url]
  end
end
