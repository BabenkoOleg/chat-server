module SerializableHelper
  def serializable_data
    subject.serializable_hash[:data]
  end

  def serializable_attributes
    serializable_data[:attributes]
  end
end
