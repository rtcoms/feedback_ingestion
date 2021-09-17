class FeedbackParser
  attr_accessor :feedback_data, :raw_info

  def initialize(raw_info)
    @raw_info = raw_info
  end

  CORE_ATTRIBUTES = [:language, :tenant_info, :source_info]
  REVIEW_ATTRIBUTES = []
  CONVERSATION_ATTRIBUTES = [:sentiment_type, :sentiment_score]
  META_DATA_ATTRIBUTES = []
  USER_ATTRIBUES = [:email, :feedback_platform_user_id]
  CONTEXT_ATTRIBUTES = [:timestamp]


  def fetch_core_attributes
    data = {}
    CORE_ATTRIBUTES.each { |key| data[key] = send("fetch_#{key}") }
    data
  end

  def fetch_review_attributes
    data = {}
    REVIEW_ATTRIBUTES.each { |key| data[key] = send("fetch_#{key}") }
    data
  end

  def fetch_conversation_attributes
    data = {}
    CONVERSATION_ATTRIBUTES.each { |key| data[key] = send("fetch_#{key}") }
    data
  end

  def fetch_metadata_attributes
    data = {}
    META_DATA_ATTRIBUTES.each { |key| data[key] = send("fetch_#{key}") }
    data
  end

  def fetch_user_attributes
    data = {}
    USER_ATTRIBUES.each { |key| data[key] = send("fetch_#{key}") }
    data
  end

  def fetch_user_attributes
    data = {}
    USER_ATTRIBUES.each { |key| data[key] = send("fetch_#{key}") }
    data
  end

  def fetch_context_info
    data = {}
    CONTEXT_ATTRIBUTES.each { |key| data[key] = send("fetch_#{key}") }
    data
  end

  def unique_identifier_hash
    (fetch_user_attributes.to_s + fetch_context_info.to_s).hash
  end

  def parsed_info
    {
      unique_identifier: unique_identifier_hash,
      core_attributes: fetch_core_attributes,
      review_attributes: fetch_review_attributes,
      conversation_attributes: fetch_conversation_attributes,
      metadata_attributes: fetch_metadata_attributes,
      user_attributes: fetch_user_attributes,
      context_info: fetch_context_info
    }
  end

end

