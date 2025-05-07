class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, :clock_out, presence: true
end
