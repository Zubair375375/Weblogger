class AddReactionsCountToUserComments < ActiveRecord::Migration[7.2]
  def change
    add_column :user_comments, :reactions_count, :integer
  end
end
