require 'rails_helper'

RSpec.describe Api::V1::SleepRecords::ClockOutContract do
  subject(:contract) { described_class.new }

  it 'fails when name is not present' do
    result = contract.call(name: nil)
    expect(result).to be_failure
  end

  it 'fails when name is not a string' do
    result = contract.call(name: 1)
    expect(result).to be_failure
  end

  it 'fails when name is empty' do
    result = contract.call(name: '')
    expect(result).to be_failure
  end

  it 'succeeds when name is present' do
    result = contract.call(name: 'Ihsan Kamil')
    expect(result).to be_success
  end
end
