class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
