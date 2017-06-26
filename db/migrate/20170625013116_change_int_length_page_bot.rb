class ChangeIntLengthPageBot < ActiveRecord::Migration[5.1]
  def change
    change_column :page_bots, :page_id, :integer, limit: 8
  end
end
