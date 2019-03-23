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

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should have_secure_password }
  it { should validate_presence_of :nickname }
  it { should validate_uniqueness_of(:nickname).case_insensitive }
end
