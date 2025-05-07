module Api
  module V1
    module Feeds
      class IndexContract < ApplicationContract
        params do
          required(:user_id).filled(:string)
        end

        rule(:user_id).validate(:uuid)
      end
    end
  end
end
