class FollowService < ApplicationService
  class << self
    def create(params)
      validation = validate_with_contract(Api::V1::Follows::CreateContract, params)
      return validation unless validation[:success]

      ActiveRecord::Base.transaction do
        follower = User.find_by(id: params[:follower_id])
        followed = User.find_by(id: params[:followed_id])
        return error_response('Follower or followed not found', {}, 400) if follower.nil? || followed.nil?
        return error_response('Already followed', {}, 400) if is_followed?(follower, followed)

        follow = Follow.create!(follower_id: follower.id, followed_id: followed.id)

        success_response('Followed successfully', follow)
      end
    end
    
    def destroy(params)
      validation = validate_with_contract(Api::V1::Follows::DestroyContract, params)
      return validation unless validation[:success]

      ActiveRecord::Base.transaction do
        follow = Follow.find_by(followed_id: params[:id], follower_id: params[:follower_id])
        return error_response('Follow not found', {}, 400) if follow.nil?

        follow.destroy!

        success_response('Unfollowed successfully', {})
      end
    end

    private

    def is_followed?(follower, followed)
      Follow.exists?(follower_id: follower.id, followed_id: followed.id)
    end
  end
end
