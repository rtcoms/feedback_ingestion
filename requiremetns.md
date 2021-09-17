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





