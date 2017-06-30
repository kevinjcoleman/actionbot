require 'rails_helper'

describe BotEventUpdaterService do
  let!(:bot) {create(:page_bot, user: create(:user))}
  let!(:event) { create(:bot_event, page_bot: bot) }
  let!(:address) { create(:address, addressable_id: event.id, addressable_type: event.class)}
  let!(:time_window) { create(:time_window, timeable_id: event.id, timeable_type: event.class)}

  let!(:event_params)  { attributes_for(:bot_event).merge({ name: 'different test',
                                                              address_line: '3205 Los Feliz Blvd, Los Angeles, CA 90039',
                                                              start_at: 'Tuesday at 230',
                                                              end_at: 'wednesday at 12'}) }

  describe 'create_event' do
    before do
      @service = BotEventUpdaterService.new(bot, event, event_params)
      @service.update_event
    end

    context 'event' do
      it 'updates an event with all valid attributes' do
        expect(event.name).to eq('different test')
      end
    end


    context 'addresses' do
      it 'updates an address' do
        expect(event.addresses.first.to_s).to eq('3205 Los Feliz Blvd, Los Angeles, CA 90039')
      end
    end

    context 'time window' do
      it 'updates the start_at' do
        expect(event.time_windows.first.start_at).to_not eq(DateTime.now)
      end

      it 'updates the start_at' do
        expect(event.time_windows.first.end_at).to_not eq((DateTime.now + 3.hours))
      end
    end
  end
end
