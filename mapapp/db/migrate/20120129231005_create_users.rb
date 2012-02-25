class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.integer :longitude
      t.integer :latitude
      t.string :address
      t.string :city
      t.string :region
      t.string :postalCode
      t.string :country
      t.string :ipaddress
      t.string :tagID

      t.timestamps
    end
  end
end
