class PublicController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  skip_before_action :authenticate_user!

  def index
    @resources = Post.includes(:users).order(created_at: :desc)
  end

end
