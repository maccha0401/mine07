module TweetsHelper
  def new_or_edit_tweet_path
    if controller.action_name == "new" || action_name == "confirm"
      confirm_tweets_path
    elsif controller.action_name == "edit"
      tweet_path(params[:id]) if controller.action_name == "edit"
    end
  end
end
