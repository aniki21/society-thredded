class AddSocialFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :psn, :string
    add_column :users, :steam, :string
    add_column :users, :xbox, :string
  end
end
