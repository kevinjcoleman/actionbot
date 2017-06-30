class AddPictureUrlToPageBot < ActiveRecord::Migration[5.1]
  def change
    add_column :page_bots, :picture_url, :string
  end
end
