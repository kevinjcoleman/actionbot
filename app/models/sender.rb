class Sender < ApplicationRecord
  FACEBOOK_PARAMS = %w(first_name
                       last_name
                       profile_pic
                       gender)
  validates :facebook_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_pic, presence: true
  validates :gender, presence: true

  has_many :event_rsvps

  def self.create_from_facebook!(facebook_id, facebook_params)
    self.create!(initialized_params(facebook_params).merge({facebook_id: facebook_id})) unless find_by(facebook_id: facebook_id)
  end

  def self.initialized_params(facebook_params)
    facebook_params.slice(*FACEBOOK_PARAMS).symbolize_keys
  end

  def update_from_facebook!(facebook_params)
    update_attributes!(facebook_params) if facebook_params != attributes.slice(*FACEBOOK_PARAMS)
  end
end
