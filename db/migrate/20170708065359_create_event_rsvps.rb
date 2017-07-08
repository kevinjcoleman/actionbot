class CreateEventRsvps < ActiveRecord::Migration[5.1]
  def change
    create_table :event_rsvps do |t|
      t.references :bot_event
      t.references :sender

      t.timestamps
    end
  end
end
