class TwitterSearch < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  belongs_to :group

  validates :search_query, presence: true
  validates :search_query, format: {with: /\A^(#|@)/, on: :create, message: "Search query must begin with @ or #"}

  def parse_tweets
    tweets = Tweet.joins(:twitter_search).where(twitter_search_id: self.id)
    tweets.map do |tweet|
      Parser.text_score(tweet)
    end
  end

  def sentiment_array
    Tweet.find_tweets(self.id).to_a
  end

  def average_sentiment
    aggregate_score = sentiment_array.reduce(0) { |accumulator, element| accumulator + element.sentiment_percentage }
    (aggregate_score / self.tweets.count).round(2)
  end

  def words_hash
    words = sentiment_array.inject("") { |accumulator, element| accumulator + element.text }
    split_words = Parser.words(words)
    word_count = Parser.word_count(split_words)
    keyword_count = Parser.keyword_values
    results = Parser.find_matches(word_count, keyword_count)
    results.map do |key, value|
      {"text": key.downcase, "size": value.abs}
    end
  end

  def sentiment_image
    if self.display_average_sentiment == 'positive'
      'green-arrow.png'
    elsif self.display_average_sentiment == 'negative'
      'red-arrow.png'
    elsif self.display_average_sentiment == 'neutral'
      'red-arrow.png'
    end
  end

  def self.twitter_search_comparison(twitter_search)
    summed = search_sentiments(twitter_search)
    counted = search_sentiment_count(twitter_search)
    average_sentiments(summed, counted)
  end

  def self.search_sentiments(twitter_search)
    TwitterSearch.where(search_query: twitter_search.search_query).joins(tweets: :sentiment).group('twitter_searches.id').sum(:sentiment_percentage)
  end

  def self.search_sentiment_count(twitter_search)
    TwitterSearch.where(search_query: twitter_search.search_query).joins(tweets: :sentiment).group('twitter_searches.id').count(:sentiment_percentage)
  end

  def self.average_sentiments(summed, counted)
    averaged = summed.values.zip(counted.values).collect {|sum, count| sum / count}
    summed.keys.zip(averaged).each_with_object({}) {|(id, averaged), averaged_hash| averaged_hash[id] = averaged }
  end

  def display_average_sentiment
    if self.average_sentiment > 0
      "positive"
    elsif self.average_sentiment < 0
      "negative"
    else
      "neutral"
    end
  end
end
