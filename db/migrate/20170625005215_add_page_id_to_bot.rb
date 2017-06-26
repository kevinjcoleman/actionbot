class AddPageIdToBot < ActiveRecord::Migration[5.1]
  def change
    add_column :bots, :page_id, :integer
  end
end
