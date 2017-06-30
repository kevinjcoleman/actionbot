class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  def to_s
    "#{street}, #{city}, #{state} #{zip}"
  end
end
