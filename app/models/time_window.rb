class TimeWindow < ApplicationRecord
  belongs_to :timeable, polymorphic: true
end
