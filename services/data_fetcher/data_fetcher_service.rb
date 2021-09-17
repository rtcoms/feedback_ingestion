class DataFetcherService
  attr_accessor :url, :customer_id, :feedback_source_type, :params, :raw_data

  def initialize(initialize_params = {})
    print "\n\n\n"
    puts "======DataFetcher========="
    puts "Data fetch request handled by: #{self.class.name} with params: #{initialize_params}"
    @url = initialize_params.fetch(:url)
    @customer_info = initialize_params.fetch(:customer_info)
    @params = initialize_params.fetch(:params)
  end

  def fetch_feedback_data
    raise 'Not Implemented'
  end
end
