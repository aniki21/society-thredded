class AddPrivateFlagToThreddedMessageboard < ActiveRecord::Migration[5.1]
  def change
    add_column :thredded_messageboards, :private, :boolean, default: false
  end
end
