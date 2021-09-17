# requirements

1. User can connect to various services from where data can be fetched
2. System should pull data from those source(on regular interval or on explicit trigger)
3. System should provide a webhook where data can be pushed by third party services
4. User should get parsed data in uniform format from all services
5. System should analyze the parsed data and give insights

### User services and APIs
* authenticate third-party services and get feedback entities
* /CreateWorkspace with multiple feedback entities
* /GetInsightReports
* Notify Data fetcher Service

### Data fetch service
* Service to fetch data from multiple services
* Notify even parser service


### Event parser service
* receive data from Data fetcher Service and webhook
* Parse and store data
* apply ML/NLP
* notify reports service


### Reports service
* recive data from event parse service
* filter, merge and store reports data

### webhook service
* provide webhook endpoint
* process webhook data
* notify Data fetcher Service



Most of these services have major use case of multi threading and so Go lang would be preferred technology. Although if ML/NLP engine required usage
of python libraries, that can be accomodated by usage of serverless technologies like aws lambda

Events database may require frequent read write and non structured data with streaming - Apache kafka
Kafka can also handle event duplication

Reports Database has to make frequent time based quesries -> TimescaleDB would be appropriate for that



# Non Functional requirements considered
* scalable - each service should be scalable without depending on other service
* performant - usage of tech which has good support for multi threading and concurrency - Go programming language
*              Reports fetching should be very fficient for time based quesrise - TimescaleDB
* USability: customer should be able to create different workspace so that different team can work on diffferent product
* System should accomodate usage of different versions of api, ML/NLP engines and it shold be easy to integrate new services
* Fault Tolerant: Downtime on one service should not affect another services



# Here is how dataflow looks like

==========> Message received to data fetcher service. customer_info: 1 || feedback_stream_info: {:workspace_id=>"1", :customer_id=>"1"}



======DataFetcher=========
Data fetch request handled by: DiscoursPostFetchService with params: {:url=>"https://meta.discourse.org/search.json?page=1&q=after%3A2021-01-01+before%3A2021-02-20", :customer_info=>1, :params=>{:page=>1, :search_term=>"test"}}



FETCHING DISCOURS POST DATA for data: {:page=>1, :search_term=>"test"}
>>>>>>>>>>>DiscoursPostFetchService: [871895]
%%%% FETCHED DATA %%%%
{"id"=>872227, "name"=>"", "username"=>"taher1", "avatar_template"=>"/user_avatar/meta.discourse.org/taher1/{size}/182563_2.png", "created_at"=>"2021-01-11T03:24:05.977Z", "cooked"=>"<p>I’ve setup email feedback forwarding as described in the post for SES but I’m not getting bounce notifications in discourse. Do i need to create a sns webhook? Or do I need to enable VERP? Please help.</p>", "post_number"=>173, "post_type"=>1, "updated_at"=>"2021-01-11T03:25:21.625Z", "reply_count"=>1, "reply_to_post_number"=>nil, "quote_count"=>0, "incoming_link_count"=>0, "reads"=>37, "readers_count"=>36, "score"=>27.4, "yours"=>false, "topic_id"=>45343, "topic_slug"=>"handling-bouncing-e-mails", "display_username"=>"", "primary_group_name"=>nil, "flair_name"=>nil, "flair_url"=>nil, "flair_bg_color"=>nil, "flair_color"=>nil, "version"=>1, "can_edit"=>false, "can_delete"=>false, "can_recover"=>false, "can_wiki"=>false, "read"=>true, "user_title"=>nil, "bookmarked"=>false, "actions_summary"=>[{"id"=>2, "count"=>1}], "moderator"=>false, "admin"=>false, "staff"=>false, "user_id"=>79907, "hidden"=>false, "trust_level"=>1, "deleted_at"=>nil, "user_deleted"=>false, "edit_reason"=>nil, "can_view_edit_history"=>true, "wiki"=>false, "customer_flair_customer"=>nil, "can_accept_answer"=>false, "can_unaccept_answer"=>false, "accepted_answer"=>false}



==========> Message received to event data processor service. payload_data_id: 872227 customer_info: 1 || feedback_stream_info: {:workspace_id=>"1", :customer_id=>"1"}
%%%% PARSED DATA %%%%
{:unique_identifier=>-3161350398033114604, :core_attributes=>{:language=>"English", :tenant_info=>"customer_id", :source_info=>"DiscoursPost"}, :review_attributes=>{}, :conversation_attributes=>{:sentiment_type=>"positive", :sentiment_score=>7}, :metadata_attributes=>{}, :user_attributes=>{:email=>nil, :feedback_platform_user_id=>79907}, :context_info=>{:timestamp=>"2021-01-11T03:24:05.977Z"}}



==========> Message received to event report generation service. parsed_data: {:unique_identifier=>-3161350398033114604, :core_attributes=>{:language=>"English", :tenant_info=>"customer_id", :source_info=>"DiscoursPost"}, :review_attributes=>{}, :conversation_attributes=>{:sentiment_type=>"positive", :sentiment_score=>7}, :metadata_attributes=>{}, :user_attributes=>{:email=>nil, :feedback_platform_user_id=>79907}, :context_info=>{:timestamp=>"2021-01-11T03:24:05.977Z"}}  customer_info: 1 || feedback_stream_info: {:workspace_id=>"1", :customer_id=>"1"}





