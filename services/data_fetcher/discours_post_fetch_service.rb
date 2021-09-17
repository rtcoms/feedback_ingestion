require_relative 'data_fetcher_service'
require 'net/http'
require 'pry'
require 'json'

class DiscoursPostFetchService < DataFetcherService
  SOURCE_TYPE = 'DiscoursePostSource'

  attr_reader :feedback_dataset

  def fetch_feedback_data
    print "\n\n\n"
    puts "FETCHING DISCOURS POST DATA for data: #{@params}"
    posts_data = JSON.parse(Net::HTTP.get(URI(url)))
    posts_ids = posts_data['posts'].map{|post| post['id']}.take(1)

    puts ">>>>>>>>>>>DiscoursPostFetchService: #{posts_ids}"

    @feedback_dataset = posts_ids.map do |post_id|
      post_api = "https://meta.discourse.org/t/45343/posts.json?post_ids[]=#{872227}"
      posts_api_data = JSON.parse(Net::HTTP.get(URI(post_api)))

      posts_api_data['post_stream']['posts']
    end.flatten

    @feedback_dataset.first
  end

end
