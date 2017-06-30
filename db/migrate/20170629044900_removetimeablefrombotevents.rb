class Removetimeablefrombotevents < ActiveRecord::Migration[5.1]
  def change
    remove_column :bot_events, :start_at
    remove_column :bot_events, :end_at
  end
end
