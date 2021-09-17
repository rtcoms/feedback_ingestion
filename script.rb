Dir.glob(File.join('/home/rtcoms/work/interview_tasks/feedback_ingestion/', '**', '*.rb'), &method(:require))

require '/home/rtcoms/work/interview_tasks/feedback_ingestion/services/data_fetcher/data_fetcher_service'

DataFetchRequestHandler.fetch_data('https://meta.discourse.org/search.json?page=1&q=after%3A2021-01-01+before%3A2021-02-20', 1, 'DiscoursePostSource', {page: 1, search_term: 'test'}, {workspace_id: '1', customer_id: '1', })

# DataFetcherService.fetch_data('https://google.com', 1, 'DiscoursePostSource', {page: 1, search_term: 'test'})
