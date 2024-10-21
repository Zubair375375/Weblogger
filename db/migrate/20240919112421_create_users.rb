class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :login, null: false
      t.string :avatar # Add the avatar field

      t.timestamps
    end

    # Add unique indexes to enforce uniqueness at the database level
    add_index :users, :email, unique: true
    add_index :users, :login, unique: true
  end
end
