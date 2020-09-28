class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.column :site_code, :string
    end
  end
end
