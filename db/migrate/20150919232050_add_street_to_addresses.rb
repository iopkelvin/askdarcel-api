class AddStreetToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :street1, :string
    add_column :addresses, :street2, :string
  end
end
