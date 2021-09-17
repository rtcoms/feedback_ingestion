require_relative 'discours_post_parser'
require_relative 'playstore_review_parser'

class EventProcessorRequestHandler
  def self.notify(feedback_source_type, payload, customer_info, feedback_stream_info)
    print "\n\n\n"
    puts "==========> Message received to event data processor service. payload_data_id: #{payload['id']} customer_info: #{customer_info} || feedback_stream_info: #{feedback_stream_info}"
    # find subservice based on source type
    data_fetcher = source_specific_parser(feedback_source_type, payload)
    parsed_data = data_fetcher.parsed_info

    puts "%%%% PARSED DATA %%%%"
    puts data_fetcher.parsed_info

    ReportGenerationRequestHandler.notify(feedback_source_type, parsed_data, customer_info, feedback_stream_info)
  end

  def self.source_specific_parser(feedback_source_type, payload)
    return DiscoursPostParser.new(payload) if feedback_source_type == 'DiscoursePostSource'
    return PlaystoreReviewParser.new(payload) if feedback_source_type == 'PlaystoreReviewSource'
  end
end
