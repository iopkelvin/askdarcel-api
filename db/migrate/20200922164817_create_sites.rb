class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.enum site_code: { sfsg: 0, sffamilies: 1 }
      t.string :id
    end
    before_create do
      self.site_code = :sfsg unless site_code
    end
    add_index :sites, :id
  end
end
