class BotEvent < ApplicationRecord
  belongs_to :page_bot
  has_one :address, as: :addressable, dependent: :destroy
  has_one :time_window, as: :timeable, dependent: :destroy
  has_many :event_rsvps

  def self.params
    [:name, :description, :picture_url]
  end
end
