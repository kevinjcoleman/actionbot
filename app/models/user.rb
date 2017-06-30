class User < ApplicationRecord
  has_many :page_bots

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at && auth.credentials.expires
      user.picture_url = auth.info.image
      user.save!
    end
  end

  def graph
    @graph ||= Koala::Facebook::API.new(oauth_token) if oauth_token
  end

  def pages
    graph.get_connections("me", "accounts").select {|page| !page["id"].to_i.in?(page_bots.pluck(:page_id)) }
  end

  def get_graph_picture
    update_attributes!(picture_url: graph.get_object("me?fields=picture")["picture"]["data"]["url"])
  end
end
