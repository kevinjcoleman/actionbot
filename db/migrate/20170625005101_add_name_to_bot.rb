class AddNameToBot < ActiveRecord::Migration[5.1]
  def change
    add_column :bots, :name, :string
  end
end
