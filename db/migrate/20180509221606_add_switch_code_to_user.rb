class AddSwitchCodeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :switch, :string
  end
end
