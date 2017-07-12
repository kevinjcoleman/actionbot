require 'rails_helper'
include BotInfo

RSpec.describe BotMessaging::IncomingMessage do
  let!(:message) {double('message', sender: {'id' => 1}, recipient: {'id' => 12}, typing_on: nil, reply: nil, is_a?: false)}
  let!(:bot) {create(:page_bot, page_id: 12, user: create(:user))}
  before { PageBot.any_instance.stub_chain(:graph, :get_object).and_return({"first_name" => 'Kevin',
                                                                            'last_name' => 'Coleman',
                                                                            'profile_pic' => "https://scontent.xx.fbcdn.net/v/t31.0-1/p720x720/10506738_10150004552801856_220367501106153455_o.jpg?oh=a678593abd34b1c87042c31551f8a4b8&oe=59C94F8B",
                                                                            'gender' => 'male',
                                                                            'facebook_id' => '1410332512382507'}) }
  describe 'with a message' do
    before { allow(message).to receive(:is_a?).with(Facebook::Messenger::Incoming::Message).and_return(true) }

    context 'with quick_reply' do
      context 'learn' do
        before { allow(message).to receive(:quick_reply) { "LEARN" } }

        it "responds with learn message" do
          BotMessaging::IncomingMessage.new(message).respond!
          expect(message).to have_received(:reply).with(learn_message_params)
        end
      end

      context 'action' do
        before { allow(message).to receive(:quick_reply) { "ACTION" } }

        it "responds with action message" do
          BotMessaging::IncomingMessage.new(message).respond!
          expect(message).to have_received(:reply).with(action_message_params)
        end
      end
    end

    context 'text' do
      before do
        allow(message).to receive(:quick_reply) { nil }
        allow(message).to receive(:text) { "Some text" }
      end

      it 'passes the text of message to API ai' do
        expect_any_instance_of(ApiAiResponder).to receive(:respond!)
        BotMessaging::IncomingMessage.new(message).respond!
      end
    end
  end

  describe 'postback' do
    before { allow(message).to receive(:is_a?).with(Facebook::Messenger::Incoming::Postback).and_return(true) }

    context 'Event postback' do
      before do
        allow(message).to receive(:payload) { "EVENT" }
      end

      it 'creates an event responder class' do
        expect_any_instance_of(EventResponder).to receive(:respond!)
        BotMessaging::IncomingMessage.new(message).respond!
      end
    end

    describe 'event specific postbacks' do
      let!(:event) {create(:bot_event, page_bot: bot)}

      context 'Event learn postback' do
        before do
          allow(message).to receive(:payload) { "EVENT-LEARN-#{event.id}" }
        end

        it 'creates an event details responder class' do
          expect_any_instance_of(EventDetailsResponder).to receive(:respond!)
          BotMessaging::IncomingMessage.new(message).respond!
        end
      end

      context 'Event rsvp postback' do
        before do
          allow(message).to receive(:payload) { "RSVP-#{event.id}" }
        end

        it 'creates an rsvp resonder class' do
          expect_any_instance_of(EventRsvpResponder).to receive(:respond!)
          BotMessaging::IncomingMessage.new(message).respond!
        end
      end

      context 'Event rsvp cancel postback' do
        before do
          allow(message).to receive(:payload) { "CANCEL-RSVP-#{event.id}" }
        end

        it 'creates an rsvp canceler class' do
          expect_any_instance_of(EventRsvpCanceler).to receive(:cancel!)
          BotMessaging::IncomingMessage.new(message).respond!
        end
      end
    end

    context 'get started postback' do
      before do
        allow(message).to receive(:payload) { "GET_STARTED_PAYLOAD" }
      end

      it 'replies with the welcome_message' do
        BotMessaging::IncomingMessage.new(message).respond!
        expect(message).to have_received(:reply).with(text: "Hello Kevin, my name is #{bot.name}. What would you like to do?")
      end
    end

    context 'missing postback' do
      before do
        allow(message).to receive(:payload) { "SOMETHING_ELSE" }
      end

      it 'replies with the missing_message' do
        BotMessaging::IncomingMessage.new(message).respond!
        expect(message).to have_received(:reply).with(text: "I'm sorry Kevin, that looks like that\'s not setup yet.")
      end
    end
  end

  describe 'referral' do
    before { allow(message).to receive(:is_a?).with(Facebook::Messenger::Incoming::Referral).and_return(true) }

    context 'event referral' do
      let!(:event) {create(:bot_event, page_bot: bot)}
      before do
        allow(message).to receive(:ref) { "EVENT-#{event.id}-REF-1" }
      end

      it 'creates an event referral class' do
        expect_any_instance_of(EventReferralResponder).to receive(:respond!)
        BotMessaging::IncomingMessage.new(message).respond!
      end
    end
  end
end
