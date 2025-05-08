class FeedService < ApplicationService
  class << self
    def index(params)
      validation = validate_with_contract(Api::V1::Feeds::IndexContract, params)
      return validation unless validation[:success]

      user = User.find_by(id: params[:user_id])
      return error_response('User not found', {}, 400) if user.nil?

      user_ids = user.followings.pluck(:followed_id)
      user_ids << user.id

      sleep_records = SleepRecord.where(user_id: user_ids, clock_in: 1.week.ago..).order(duration: :desc)

      success_response('Feeds fetched successfully', sleep_records)
    end
  end
end
