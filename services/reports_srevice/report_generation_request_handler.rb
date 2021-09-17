class ReportGenerationRequestHandler
  def self.notify(feedback_source_type, parsed_data, customer_info, feedback_stream_info)
    print "\n\n\n"
    puts "==========> Message received to event report generation service. parsed_data: #{parsed_data}  customer_info: #{customer_info} || feedback_stream_info: #{feedback_stream_info}"
    # find subservice based on source type

    # ignore if entry already exists in reprots database for give feedback_source_type and unique_identifier
    # merge data if parsed data is in same context
    # insert if new data
  end
end
