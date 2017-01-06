class UsersController < ApplicationController
  def index
    @users = User.all_except(current_user.id)
    @users.each do |user|
      print user.first_name
    end
    render json: @users
  end
end
