describe BaseSerializer do
  subject { BaseSerializer.from_object({ id: 0 }) }

  it { expect(serializable_data).to have_key(:id) }
  it { expect(serializable_data[:id]).to eq('0') }
end
