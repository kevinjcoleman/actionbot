class RenameBot < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :bots, :page_bots
  end

  def self.down
    rename_table :page_bots, :bots
  end
end
