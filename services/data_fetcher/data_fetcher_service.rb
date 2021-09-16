class DataFetcherService
  attr_accessor :url, :customer_id, :feedback_source_type, :params, :raw_data

  def initialize(initialize_params = {})
    puts '==='
    puts initialize_params
    @url = initialize_params.fetch(:url)
    @customer_id = initialize_params.fetch(:customer_id)
    @params = initialize_params.fetch(:params)
  end

  def fetch_feedback_data
    @source_fetcher = source_specific_data_fetch
    @raw_data = @source_fetcher.fetch_feedback_data
  end

  def send_feedback_data
    raise 'DATA NOT AVAILABLE' unless @raw_data.present?

    EventsProcessor.fetch_uniform_report_data(user_info, context_info, @raw_data)
  end
end
