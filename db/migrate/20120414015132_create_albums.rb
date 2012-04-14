class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :description
      t.integer :photo_id

      t.timestamps
    end
  end
end
