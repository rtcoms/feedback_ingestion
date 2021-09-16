require_relative 'discours_post_fetch_service'
require_relative 'playstore_review_fetch_service'

class DataFetchRequestHandler
  def self.fetch_data(url, customer_id, feedback_source_type, params)
    # find subservice based on source type
    data_fetcher = source_specific_data_fetcher(url, customer_id, feedback_source_type, params)
    data_fetcher.fetch_feedback_data and data_fetcher.send_feedback_data
  end

  private

  def self.source_specific_data_fetcher(url, customer_id, feedback_source_type, params)
    return DiscoursPostFetchService.new({url: url, customer_id: customer_id, params: params}) if feedback_source_type == 'DiscoursePostSource'
    return PlaystoreReviewFetchService.new({url: url, customer_id: customer_id, params: params}) if feedback_source_type == 'PlaystoreReviewSource'
  end
end
