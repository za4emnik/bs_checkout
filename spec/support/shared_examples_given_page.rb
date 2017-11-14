RSpec.shared_examples 'given page' do
  it 'response should be 200' do
    expect(subject.status).to eq(200)
  end
end
