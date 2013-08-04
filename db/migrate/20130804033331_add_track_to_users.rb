class AddTrackToUsers < ActiveRecord::Migration
  def change
    add_column :users, :track, :text
    User.update_all :track => {}.to_yaml
  end
end
