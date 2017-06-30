require 'rails_helper'

describe BotEventCreationService do
  let(:bot) {create(:page_bot, user: create(:user))}
  let(:event_params) { attributes_for(:bot_event).
                                     merge({address_line: '200 N Spring St, Los Angeles, CA 90012',
                                            start_at: 'Tuesday at 230',
                                            end_at: 'wednesday at 12'})}

  describe 'create_event' do
    before do
      @service = BotEventCreationService.new(bot, event_params)
      @service.create_event
      @event = @service.event
    end

    context 'event' do
      it "creates an event" do
        expect(BotEvent.count).to eq(1)
      end

      it 'creates an event with all valid attributes' do
        [:name, :picture_url, :description].each do |column|
          expect(@event.send(column)).to_not be_nil
        end
      end
    end


    context 'addresses' do
      it 'creates an address' do
        expect(@event.addresses.first).to_not be_nil
      end

      it 'creates an address with all valid attributes' do
        [:street, :city, :state, :zip].each do |column|
          expect(@event.addresses.first.send(column)).to_not be_nil
        end
      end
    end

    context 'time window' do
      it 'creates a timewindow' do
        expect(@event.time_windows.first).to_not be_nil
      end

      it 'creates an address with all valid attributes' do
        [:start_at, :end_at].each do |column|
          expect(@event.time_windows.first.send(column)).to_not be_nil
        end
      end
    end
  end
end
