Dir.glob(File.join('/home/rtcoms/work/interview_tasks/feedback_ingestion/', '**', '*.rb'), &method(:require))

class DiscoursePostSource < FeedbackSource
  def send_message_to_data_fetcher_service(api_credentials: , params: )
    raise 'Not Implemented'
  end
end
