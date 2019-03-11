module Authenticatable
  extend ActiveSupport::Concern

  def issue_credential_headers(user)
    payload = { user: user.as_json(only: [:id, :nickname]) }
    now = Time.now.to_i

    response.set_header(
      'X-Access-Token',
      ChatServer::Auth.issue(payload.merge({ exp: now + 3600 }))
    )

    response.set_header(
      'X-Refresh-Token',
      ChatServer::Auth.issue(payload.merge({ exp: now + 86400 }))
    )
  end
end
