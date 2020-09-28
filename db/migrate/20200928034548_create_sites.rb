class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.column :site_code, :integer, default: 'sfsg'
    end
  end
end
