class AddAddressToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :address, :string
    add_column :profiles, :city, :string
    add_column :profiles, :province, :string
    add_column :profiles, :postal_code, :string
  end

  def self.down
    remove_column :profiles, :postal_code
    remove_column :profiles, :province
    remove_column :profiles, :city
    remove_column :profiles, :address
  end
end
