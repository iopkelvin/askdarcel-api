class AddHoursKnownToSchedules < ActiveRecord::Migration[5.2]
  def change
  	add_column :schedules, :hours_known, :boolean, default: true
  end
end
