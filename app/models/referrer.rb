class Referrer < ApplicationRecord
  belongs_to :referrer, class_name: 'Sender'
  belongs_to :referree, class_name: 'Sender'
  belongs_to :referrable, polymorphic: true
end
