class AddPublicToMedia < ActiveRecord::Migration
  def change
    add_column :media, :public, :boolean, :default => false
  end
end
