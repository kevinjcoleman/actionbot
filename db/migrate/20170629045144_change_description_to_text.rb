class ChangeDescriptionToText < ActiveRecord::Migration[5.1]
  def change
    change_column :bot_events, :description, :text
  end
end
