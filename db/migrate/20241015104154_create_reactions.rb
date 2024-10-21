class CreateReactions < ActiveRecord::Migration[7.2]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_comment, null: false, foreign_key: true
      # t.integer :user_id
      # t.integer :user_comment_id

      t.timestamps
    end
  end
end
