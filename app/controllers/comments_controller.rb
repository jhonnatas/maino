class CommentsController < ApplicationController
  before_action :set_post
  skip_before_action :authenticate_user!, only: [:create], raise: false

  def create
    @comment = @post.comments.create(comment_params)
    
    if current_user 
      @comment.usercomment = current_user.email
    else
      @comment.usercomment = 'Anônimo'
    end
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, success: 'Comentário foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to posts_path, success: 'Comentário não foi criado.' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :usercomment)
  end
end
