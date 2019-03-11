# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  nickname        :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_nickname  (nickname) UNIQUE
#

class User < ApplicationRecord
  # === authentication ===
  has_secure_password

  # === validations ===
  validates :nickname, presence: true, uniqueness: { case_sensitive: false }
end
