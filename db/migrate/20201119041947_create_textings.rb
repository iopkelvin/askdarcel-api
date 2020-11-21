class CreateTextings < ActiveRecord::Migration[5.2]
  def change
    create_table :textings do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :tags
      t.string :resources

      t.timestamps
    end
  end
end