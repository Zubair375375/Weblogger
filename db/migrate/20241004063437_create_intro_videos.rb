class CreateIntroVideos < ActiveRecord::Migration[7.2]
  def change
    create_table :intro_videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :video_url

      t.timestamps
    end
  end
end
