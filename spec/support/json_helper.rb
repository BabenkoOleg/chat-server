module JsonHelper
  def json
    hash = JSON.parse(response.body)
    hash = hash.with_indifferent_access if hash.is_a? Hash
    hash
  end
end
