class CreateProfileShares < ActiveRecord::Migration[7.2]
  def change
    create_table :profile_shares do |t|
      t.integer :user_id
      t.integer :current_user_id
      t.datetime :shared_at

      t.timestamps
    end
  end
end
