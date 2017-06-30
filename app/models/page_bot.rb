class PageBot < ApplicationRecord
  belongs_to :user
  has_many :bot_events

  def add_whitelisted_domain(domain)
    raise "Too many domains, there's a limit of 10." if whitelisted_domains.size >= 10
    thread_settings.add_domain(domain)
  end

  def remove_whitelisted_domain(domain)
    thread_settings.remove_domain(domain)
  end

  def whitelisted_domains
    thread_settings.domains
  end

  def thread_settings
    FacebookThreadSettings.new(self)
  end

  def graph
    @graph ||= Koala::Facebook::API.new(access_token) if access_token
  end

  def get_graph_picture
    update_attributes!(picture_url: graph.get_object("me?fields=picture")["picture"]["data"]["url"])
  end

  # Add subscribe functionality
  # Add whitelisted domain functionality for generic templates
  # Add menu + get started functionality
end
