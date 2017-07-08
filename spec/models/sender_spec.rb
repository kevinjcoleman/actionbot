require 'rails_helper'

RSpec.describe Sender, type: :model do
  let!(:facebook_params) { {"first_name" => "Tom",
                            "last_name" => "Ricesky",
                            "profile_pic" => "https://scontent.xx.fbcdn.net/v/t31.0-1/p720x720/10506738_10150004552801856_220367501106153455_o.jpg?oh=a678593abd34b1c87042c31551f8a4b8&oe=59C94F8B",
                            "locale" => "en_US",
                            "timezone" => -7,
                            "gender" => "male"}}
  let!(:facebook_id) {'1410332512382507'}

  describe 'create_from_facebook' do
    before { @sender = Sender.create_from_facebook!(facebook_id, facebook_params)}
    it 'creates' do
      expect(@sender).to_not be_nil
    end
  end

  describe 'update_from_facebook!' do
    let!(:sender) {create(:sender)}
    let!(:update_params) { facebook_params.slice(*Sender::FACEBOOK_PARAMS) }
    before { sender.update_from_facebook!(update_params)}

    it "updates the sender" do
      expect(sender.first_name).to eq('Tom')
      expect(sender.last_name).to eq('Ricesky')
    end
  end
end
