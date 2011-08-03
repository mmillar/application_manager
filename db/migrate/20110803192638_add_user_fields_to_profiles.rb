class AddUserFieldsToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :bio, :text
    add_column :profiles, :picture, :string
  end

  def self.down
    remove_column :profiles, :picture
    remove_column :profiles, :bio
  end
end
