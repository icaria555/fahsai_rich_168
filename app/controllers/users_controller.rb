class UsersController < ApplicationController
  def index
    @users = User.all
    @users.each do |user|
      print user.first_name
    end
    @user = User.find_by_id(1)
    @user.first_name = "Tatchagon"
    print @user.nil?
    render json: @users
  end
end
