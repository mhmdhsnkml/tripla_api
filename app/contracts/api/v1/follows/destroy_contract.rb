module Api
  module V1
    module Follows
      class DestroyContract < ApplicationContract
        params do
          required(:id).filled(:string)
          required(:follower_id).filled(:string)
        end

        rule(:id).validate(:uuid)
        rule(:follower_id).validate(:uuid)
      end
    end
  end
end
