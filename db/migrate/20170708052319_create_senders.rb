class CreateSenders < ActiveRecord::Migration[5.1]
  def change
    create_table :senders do |t|
      t.string :first_name
      t.string :last_name
      t.string :profile_pic
      t.string :gender
      t.string :facebook_id

      t.timestamps
    end
  end
end
