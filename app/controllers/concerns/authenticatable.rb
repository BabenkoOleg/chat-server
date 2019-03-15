module Authenticatable
  extend ActiveSupport::Concern

  def set_credential_headers(credentials)
    response.set_header('access-token',  credentials[:access])
    response.set_header('refresh-token', credentials[:refresh])
    response.set_header('expires',       credentials[:exp])
    response.set_header('client',        credentials[:client])
    response.set_header('uid',           credentials[:uid])
  end
end
