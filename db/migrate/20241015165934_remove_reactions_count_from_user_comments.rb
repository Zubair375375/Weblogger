class RemoveReactionsCountFromUserComments < ActiveRecord::Migration[7.2]
  def change
    remove_column :user_comments, :reactions_count, :integer
  end
end
