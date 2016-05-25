class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.references :imageable, polymorphic: true, index: true
    end
  end
end
