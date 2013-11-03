class CreateSurveyUsers < ActiveRecord::Migration
  def change
    create_table :survey_users do |t|
      t.integer :survey_id
      t.integer :user_id
      t.integer :rate
      t.string :main
      t.string :demo

      t.timestamps
    end

    add_foreign_key :survey_users, :surveys
    add_foreign_key :survey_users, :users

  end
end
