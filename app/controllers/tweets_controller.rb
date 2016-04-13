# == Schema Information
#
# Table name: tweets
#
#  id                :integer          not null, primary key
#  text              :text
#  favorite_count    :integer
#  retweets          :integer
#  tweet_date        :date
#  user_verified     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  document_id       :integer
#  profile_image_url :string
#  name              :string
#  location          :string
#  twitter_search_id :integer
#

class TweetsController < ApplicationController

  def create
    query = params[:search_parameter]
    language = params[:language_code][:id]
    tweet_count = params[:tweet_count].to_i
    result_type = params[:result_type]

    @group = Group.find(params[:group_id])
    @twitter_search = TwitterSearch.create(search_query: query, group: @group)
    tweets = TweetService.sanitize_tweets(query, language, result_type, tweet_count)
    # tweets_string = Tweet.stringify_tweets(tweets)
    @twitter_search.tweets += tweets
    # @twitter_search.text = tweets_string

    if @twitter_search.save
      redirect_to group_twitter_search_path(@group.id, @twitter_search.id)
    else
      flash.now[:error] = "Please try again."
      redirect_to group_path(@group)
    end
  end
end
