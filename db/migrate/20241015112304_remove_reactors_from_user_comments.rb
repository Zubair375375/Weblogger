class RemoveReactorsFromUserComments < ActiveRecord::Migration[7.2]
  def change
    remove_column :user_comments, :Reactors, :integer
  end
end
