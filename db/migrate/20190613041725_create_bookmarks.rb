# Create the `bookmarks` table. If a cronjob or some other system is scanning
# through a database table and needs to save its current place, it can save a
# bookmark.
class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.string 'identifier'
      t.datetime 'date_value'
      t.integer 'id_value'
      t.timestamps
      t.index ['identifier'], unique: true
    end
  end
end
