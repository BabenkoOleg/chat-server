class BaseSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  class << self
    def from_object(object)
      new(OpenStruct.new({ id: 0 }.merge(object)))
    end
  end
end
