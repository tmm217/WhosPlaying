class CreateVenuefollows < ActiveRecord::Migration[6.0]
  def change
    create_table :venuefollows do |t|
      t.integer :venue_id
      t.integer :fan_id

      t.timestamps
    end
  end
end
