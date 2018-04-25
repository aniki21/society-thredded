module ApplicationHelper
  include ThemesHelper
  
  def page_title
    safe_join [content_for(:page_title) || content_for(:thredded_page_title),
               t('brand.name')].compact, ' - '
  end
  
  # @param datetime [DateTime]
  # @param default [String] a string to return if time is nil.
  # @return [String] html_safe datetime presentation
  def time_ago(datetime, default: '-')
    timeago_tag datetime,
                lang: I18n.locale.to_s.downcase,
                format: (lambda do |t, _opts|
                  t.year == Time.current.year ? :short : :long
                end),
                nojs: true,
                date_only: false,
                default: default
  end
  
  # Override the default timeago_tag_content from rails-timeago
  def timeago_tag_content(time, time_options = {})
    if time_options[:nojs] &&
       (time_options[:limit].nil? || time_options[:limit] < time)
      t 'common.time_ago', time: time_ago_in_words(time)
    else
      I18n.l time.to_date, format: time_options[:format]
    end
  end

  def unread(messageboard)
    thredded_current_user.is_a?(User) ? Thredded::Topic.where(messageboard_id: messageboard.id).joins('INNER JOIN thredded_user_topic_read_states ON thredded_topics.id = thredded_user_topic_read_states.postable_id').where("thredded_user_topic_read_states.read_at < thredded_topics.last_post_at AND thredded_user_topic_read_states.user_id = ?", thredded_current_user).any? : false
  end

  def authority(user)
    icon = if user.moderator?
             '<i class="far fa-star" title="Moderator" style="font-size: 0.7em;"></i>'
           else
             ''
           end
    icon.html_safe
  end
end
