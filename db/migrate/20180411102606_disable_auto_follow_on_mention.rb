class DisableAutoFollowOnMention < ActiveRecord::Migration[5.1]
  def change
    change_column :thredded_user_preferences, :follow_topics_on_mention, :boolean, default: false
    change_column :thredded_user_messageboard_preferences, :follow_topics_on_mention, :boolean, default: false
  end
end
