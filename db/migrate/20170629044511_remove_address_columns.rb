class RemoveAddressColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :bot_events, :address1
    remove_column :bot_events, :city
    remove_column :bot_events, :state
    remove_column :bot_events, :zip
    remove_column :bot_events, :country_code
  end
end
