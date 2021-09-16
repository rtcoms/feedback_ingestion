class FeedbackParser
  attr_accessor :feedback_data, :raw_info

  CORE_ATTRIBUTES = ["language, :tenant_info, :source_info"]
  REVIEW_ATTRIBUTES = []
  CONVERSATION_ATTRIBUTES = []
  META_DATA_ATTRIBUTES = []


  def fetch_core_attributes
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

  def parsed_info
    {
      core_attributes: fetch_core_attributes,
      review_attributes: fetch_review_attributes,
      conversation_attributes: fetch_conversation_attributes,
      metadata_attributes: fetch_metadata_attributes
    }
  end

end

