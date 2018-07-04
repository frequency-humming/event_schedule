class CreateEventsAttendings < ActiveRecord::Migration
  def change
    create_table :events_attendings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
