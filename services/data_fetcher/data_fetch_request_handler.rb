require_relative 'discours_post_fetch_service'
require_relative 'playstore_review_fetch_service'
require_relative '../events_processor/event_processor_request_handler'

class DataFetchRequestHandler
  def self.fetch_data(url, customer_info, feedback_source_type, params, feedback_stream_info)
    print "\n\n\n"
    puts "==========> Message received to data fetcher service. customer_info: #{customer_info} || feedback_stream_info: #{feedback_stream_info}"
    # find subservice based on source type
    data_fetcher = source_specific_data_fetcher(url, customer_info, feedback_source_type, params)
    data_fetcher.fetch_feedback_data

    puts "%%%% FETCHED DATA %%%%"
    puts data_fetcher.feedback_dataset

    self.send_feedback_data_to_event_parser_service(feedback_source_type, data_fetcher.feedback_dataset, customer_info, feedback_stream_info)
  end

  private

  def self.source_specific_data_fetcher(url, customer_info, feedback_source_type, params)
    return DiscoursPostFetchService.new({url: url, customer_info: customer_info, params: params}) if feedback_source_type == 'DiscoursePostSource'
    return PlaystoreReviewFetchService.new({url: url, customer_info: customer_info, params: params}) if feedback_source_type == 'PlaystoreReviewSource'
  end

  def self.send_feedback_data_to_event_parser_service(feedback_source_type, feedback_dataset, customer_info, feedback_stream_info)
    feedback_dataset.each do |feedback_data|
      EventProcessorRequestHandler.notify(feedback_source_type, feedback_data, customer_info, feedback_stream_info)
    end
  end
end
