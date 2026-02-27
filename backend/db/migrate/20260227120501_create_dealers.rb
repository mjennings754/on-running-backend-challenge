class CreateDealers < ActiveRecord::Migration[8.1]
  def change
    create_table :dealers do |t|
      t.string :remote_id
      t.string :name
      t.string :phone
      t.string :street
      t.string :city
      t.string :zipcode
      t.string :country
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.datetime :synced_at

      t.timestamps
    end
    add_index :dealers, :remote_id, unique: true
    add_index :dealers, :country
    add_index :dealers, [:latitude, :longitude]
  end
end
