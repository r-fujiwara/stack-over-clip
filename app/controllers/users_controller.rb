class UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!

  def show
    @resource = User.find_by(name: params[:name])
  end

end
