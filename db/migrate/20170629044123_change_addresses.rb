class ChangeAddresses < ActiveRecord::Migration[5.1]
  def change
    rename_column :addresses, :bot_event_type, :addressable_type
    rename_column :addresses, :bot_event_id, :addressable_id
  end
end
