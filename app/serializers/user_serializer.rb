# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  nickname        :string           not null
#  password_digest :string
#  tokens          :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_nickname  (nickname) UNIQUE
#

class UserSerializer < BaseSerializer
  attributes :nickname
end
