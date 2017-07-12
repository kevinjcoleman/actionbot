class CreateReferrers < ActiveRecord::Migration[5.1]
  def change
    create_table :referrers do |t|
      t.references :referrer, index: true, foreign_key: { to_table: :senders }
      t.references :referree, index: true, foreign_key: { to_table: :senders }
      t.references :referrable, polymorphic: true

      t.timestamps
    end
  end
end
