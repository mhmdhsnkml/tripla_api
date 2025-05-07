class SleepRecordService < ApplicationService
  class << self
    def clock_in(params)
      validation = validate_with_contract(Api::V1::SleepRecords::ClockInContract, params)
      return validation unless validation[:success]

      ActiveRecord::Base.transaction do
        user = User.find_or_create_by(name: params[:name])
        return error_response('User already clocked in', {}, 400) if is_clock_in?(user)
        
        sleep_record = SleepRecord.create!(user: user, clock_in: Time.now)

        success_response('Clock in successfully', user.sleep_records.order(created_at: :desc))
      end
    end

    def clock_out(params)
      validation = validate_with_contract(Api::V1::SleepRecords::ClockOutContract, params)
      return validation unless validation[:success]

      ActiveRecord::Base.transaction do
        current_time = Time.now
        user = User.find_by(name: params[:name])
        return error_response('User not found', {}, 400) if user.nil?

        sleep_record = SleepRecord.find_by(user: user, clock_out: nil)
        return error_response('User not clocked in', {}, 400) if sleep_record.nil?

        sleep_record.update!(clock_out: current_time, duration: current_time - sleep_record.clock_in)

        success_response('Clock out successfully', user.sleep_records.order(created_at: :desc))
      end
    end

    private

    def is_clock_in?(user)
      SleepRecord.exists?(user: user, clock_out: nil)
    end
  end
end
