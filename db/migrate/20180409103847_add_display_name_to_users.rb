class AddDisplayNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :display_name, :string, null: false
    DbTextSearch::CaseInsensitive.add_index connection, :users, :display_name,
                                            unique: true
  end
end
