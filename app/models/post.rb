class Post < ActiveRecord::Base
  has_many :users_posts
  has_many :users, through: :users_posts

  after_create do |record|
    record.detect!
    record.save!
  end

  class << self
    def types
      %w(javascript jquery reactjs angularjs ruby rails sinatra java).freeze
    end

    def shared_post_users(url, user_id)
      shared_posts = where(url: url)
      others_posts = shared_posts.to_a.delete_if{|post| post.user_id == user_id}
      others_posts.map{|post| User.find_by(id: post.user_id)}
    end

    def shared_post_exist?(url)
      where(url: url).length > 1
    end

    def daily(user_id:, time:)
      where(user_id: user_id, created_at: time.beginning_of_day..time.end_of_day)
    end

    def monthly(user_id:, time:)
      where(user_id: user_id, created_at: time.beginning_of_month..time.at_end_of_month)
    end

  end

  def detect!
    words = title.split("\s").map!(&:underscore)
    common = words & self.class.types
    self.category =
      if common.length > 0
        common.first
      else
        'other'
      end
  end

  def user_name
    User.find_by(id: user_id).name
  end

end
