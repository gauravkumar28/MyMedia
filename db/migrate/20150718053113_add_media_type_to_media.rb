class AddMediaTypeToMedia < ActiveRecord::Migration
  def change
    add_column :media, :media_type, :integer
  end
end
