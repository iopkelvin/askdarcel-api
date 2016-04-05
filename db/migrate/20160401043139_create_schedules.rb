class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.timestamps null: false

      t.references :resource, index: true, foreign_key: true, null: false
    end
  end
end
