module Authenticatable
  extend ActiveSupport::Concern

  def render_user_credentials(user)
    payload = { user: user.as_json(only: [:id, :nickname]) }
    now = Time.now.to_i

    render json: CredentialsSerializer.from_object({
      access_token: ChatServer::Auth.issue(payload.merge({ exp: now + 3600 })),
      refresh_token: ChatServer::Auth.issue(payload.merge({ exp: now + 86400 }))
    }), status: 201
  end
end
