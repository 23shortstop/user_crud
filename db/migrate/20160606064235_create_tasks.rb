class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true
      t.references :image, index: true
      t.string :status
      t.string :type
      t.hstore :params
      t.string :result
    end
  end
end
