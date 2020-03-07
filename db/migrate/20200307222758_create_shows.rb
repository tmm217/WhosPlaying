class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :show_bands
      t.boolean :is_soldout
      t.string :show_image
      t.integer :host_id
      t.datetime :show_date

      t.timestamps
    end
  end
end
