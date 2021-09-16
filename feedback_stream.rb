class FeedbackStream
  attr_accessor :workspace, :customer_feedback_entity, :active, :last_fetched_at

  def send_data_fetch_message
    DataFetcherService.fetch_data()
  end
end
