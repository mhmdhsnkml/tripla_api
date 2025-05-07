module Api
  module V1
    module SleepRecords
      class ClockInContract < ApplicationContract
        params do
          required(:name).filled(:string)
        end
      end
    end
  end
end
