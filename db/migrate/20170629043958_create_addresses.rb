class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country_code
      t.references :bot_event, polymorphic: true

      t.timestamps
    end
  end
end
