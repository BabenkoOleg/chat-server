describe UserSerializer do
  let(:user) { create(:user) }
  subject { UserSerializer.new(user) }

  it { expect(serializable_attributes[:nickname]).to eq(user.nickname) }
end
