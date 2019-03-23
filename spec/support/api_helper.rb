module ApiHelper
  def authenticated_header(request)
    jwt = Auth.issue({})
    request.headers.merge!('Authorization': "Bearer #{jwt}")
  end
end
