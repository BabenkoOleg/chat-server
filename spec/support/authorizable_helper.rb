module AuthorizableHelper
  def authorize(user, credentials = nil)
    credentials ||= user.authorize!

    request.headers.merge!(
      'access-token':  credentials[:access],
      'client':        credentials[:client],
      'uid':           credentials[:uid]
    )
  end
end
