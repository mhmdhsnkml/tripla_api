require 'rails_helper'

RSpec.describe Api::V1::Feeds::IndexContract do
  subject(:contract) { described_class.new }

  it 'fails when user_id is not present' do
    result = contract.call(user_id: nil)
    expect(result).to be_failure
  end
  
  it 'fails when user_id is not a string' do
    result = contract.call(user_id: 1)
    expect(result).to be_failure
  end

  it 'fails when user_id is not a valid UUID' do
    result = contract.call(user_id: 'invalid-uuid')
    expect(result).to be_failure
  end

  it 'succeeds when user_id is present' do
    result = contract.call(user_id: SecureRandom.uuid)
    expect(result).to be_success
  end
end
