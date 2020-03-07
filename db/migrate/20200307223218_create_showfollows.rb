class CreateShowfollows < ActiveRecord::Migration[6.0]
  def change
    create_table :showfollows do |t|
      t.integer :show_id
      t.integer :attendee_id

      t.timestamps
    end
  end
end
