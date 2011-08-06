class AddTokenFieldToProfile < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :profiles, :token, :string

      Profile.all.each do |profile|
        profile.token = rand(48**12).to_s(36)
        profile.save
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :profiles, :token
    end
  end
end
