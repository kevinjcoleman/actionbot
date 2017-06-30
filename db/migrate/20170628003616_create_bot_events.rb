class CreateBotEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :bot_events do |t|
      t.references :page_bot, foreign_key: true
      t.string :name
      t.string :description
      t.datetime :start_at
      t.datetime :end_at
      t.string :address1
      t.string :city
      t.string :state
      t.string :zip
      t.string :country_code
      t.string :picture_url

      t.timestamps
    end
  end
end
