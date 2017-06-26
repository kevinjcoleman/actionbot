class User < ApplicationRecord
  has_many :page_bots

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at && auth.credentials.expires
      user.save!
    end
  end

  def graph
    @graph ||= Koala::Facebook::API.new(oauth_token) if oauth_token
  end

  def pages
    graph.get_connections("me", "accounts")
  end
end
