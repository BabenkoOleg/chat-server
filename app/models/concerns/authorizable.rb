module Authorizable
  extend ActiveSupport::Concern

  def authorize!(client = nil)
    client ||= SecureRandom.base64(6)
    now = Time.now.to_i

    credentials = tokens[client] || {}
    credentials = credentials.with_indifferent_access

    credentials[:last] = credentials[:access]
    credentials[:updated_at] = credentials[:access].present? ? now : nil
    credentials[:access] = SecureRandom.hex(10)
    credentials[:refresh] = SecureRandom.hex(20)
    credentials[:exp] = now + Rails.application.credentials[Rails.env.to_sym][:access_token_exp]

    tokens[client] = credentials
    tokens.reject! { |k, v| v['exp'] < now }

    update(tokens: tokens)

    credentials.merge({ client: client, uid: nickname })
  end

  def authorized?(client, access_token)
    credentials = tokens[client]
    return false unless credentials

    credentials = credentials.with_indifferent_access
    now = Time.now.to_i

    access_token_valid = credentials[:access] == access_token
    access_token_alive = credentials[:exp] && credentials[:exp] > now

    return true if access_token_valid && access_token_alive

    last_token_valid = credentials[:last] == access_token
    last_token_alive = credentials[:updated_at] && credentials[:updated_at] + 30 < now

    last_token_valid && last_token_alive
  end
end
