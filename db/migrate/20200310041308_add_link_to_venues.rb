class AddLinkToVenues < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :venue_link, :string
  end
end
