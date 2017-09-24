class StaticPagesController < ApplicationController
  def index
    @posts = Post.all.limimt(3).order("created_at desc")
  end
end
