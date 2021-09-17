require_relative 'feedback_parser'

class DiscoursPostParser < FeedbackParser
  META_DATA_ATTRIBUTES = [:country]

  def fetch_language
    'English'
  end

  def fetch_tenant_info
    'customer_id'
  end

  def fetch_source_info
    'DiscoursPost'
  end

  def fetch_timestamp
    @raw_info['created_at']
  end

  def fetch_country
    'India'
  end

  def fetch_sentiment_type
    'positive'
  end

  def fetch_sentiment_score
    7
  end

  def fetch_email
    nil
  end

  def fetch_feedback_platform_user_id
    @raw_info['user_id']
  end

end

