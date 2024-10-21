class CreateUserComments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :intro_video, null: false, foreign_key: true
      t.text :content # Stores the comment content

      t.timestamps
    end
  end
end
