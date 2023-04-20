class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => :index
  
  def index
    @posts = Post.by_recently_created.page params[:page]
  end
end
