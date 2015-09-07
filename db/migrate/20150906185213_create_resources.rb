class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.string :email
      t.text :summary
      t.text :content
      t.text :website

      # wikimedia references
      t.integer :page_id
      t.integer :revision_id

      t.timestamps null: false
    end
    add_index :resources, :page_id, unique: true
  end
end
