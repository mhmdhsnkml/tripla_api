require 'rails_helper'

RSpec.describe Api::V1::Follows::DestroyContract do
  subject(:contract) { described_class.new }

  it 'fails when follower_id is not present' do
    result = contract.call(follower_id: nil)
    expect(result).to be_failure
  end

  it 'fails when follower_id is not a string' do
    result = contract.call(follower_id: 1)
    expect(result).to be_failure
  end

  it 'fails when follower_id is not a valid UUID' do
    result = contract.call(follower_id: 'invalid-uuid')
    expect(result).to be_failure
  end

  it 'fails when id is not present' do
    result = contract.call(id: nil)
    expect(result).to be_failure
  end

  it 'fails when id is not a string' do
    result = contract.call(id: 1)
    expect(result).to be_failure
  end

  it 'fails when id is not a valid UUID' do
    result = contract.call(id: 'invalid-uuid')
    expect(result).to be_failure
  end

  it 'succeeds when follower_id and id are present' do
    result = contract.call(follower_id: SecureRandom.uuid, id: SecureRandom.uuid)
    expect(result).to be_success
  end
end
