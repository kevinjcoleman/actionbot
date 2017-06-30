
FactoryGirl.define do
  factory :time_window do
    start_at { DateTime.now }
    end_at { DateTime.now + 3.hours }
  end
end
