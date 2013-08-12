class AddIsLiveToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :is_live, :boolean, :default => 1
  end
end
