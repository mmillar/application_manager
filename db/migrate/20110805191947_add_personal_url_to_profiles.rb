class AddPersonalUrlToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :personal_url, :string
  end

  def self.down
    remove_column :profiles, :personal_url
  end
end
