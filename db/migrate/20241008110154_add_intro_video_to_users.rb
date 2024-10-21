class AddIntroVideoToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :user_comments, :intro_video_id, :string
  end
end
# this file is not AddIntroVideoToUsers, this is AddIntroVideoToUserComments