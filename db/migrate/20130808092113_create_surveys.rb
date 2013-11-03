class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :address
      t.string :main
      t.string :demo

      t.timestamps
    end
  end
end
