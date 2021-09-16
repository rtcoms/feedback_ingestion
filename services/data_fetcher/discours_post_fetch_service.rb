require_relative 'data_fetcher_service'
require 'net/http'

class DiscoursPostFetchService < DataFetcherService
  SOURCE_TYPE = 'DiscoursePostSource'

  def fetch_feedback_data
    puts "FETCHING DISCOURS POST DATA for data: #{@params}"
    puts Net::HTTP.get(URI(url))
  end

  def send_feedback_data
    puts 'SENDING DISCOURS POST DATA'
  end

end
