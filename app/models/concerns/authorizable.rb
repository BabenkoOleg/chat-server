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

    access_token_and_exp_present = credentials[:access].present? && credentials[:exp].present?
    return false unless access_token_and_exp_present

    access_token_valid = credentials[:access] == access_token
    access_token_alive = credentials[:exp] > now

    return true if access_token_valid && access_token_alive

    last_and_updated_at_present = credentials[:last].present? && credentials[:updated_at].present?
    return false unless last_and_updated_at_present

    last_token_exp = Rails.application.credentials[Rails.env.to_sym][:last_token_exp]
    last_token_valid = credentials[:last] == access_token
    last_token_alive = credentials[:updated_at] + last_token_exp > now

    last_token_valid && last_token_alive
  end
end
