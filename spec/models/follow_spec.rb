require 'rails_helper'

RSpec.describe Follow, type: :model do
  it { should belong_to(:follower) }
  it { should belong_to(:followed) }
end
