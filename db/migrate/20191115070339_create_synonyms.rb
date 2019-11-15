class CreateSynonyms < ActiveRecord::Migration[5.2]
  def change
    create_table :synonyms do |t|
      t.string :type
      t.text :synonyms, array: true, default: []
      t.string :objectID

      t.timestamps
    end
  end
end
