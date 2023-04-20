class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), success: 'Comentário foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to post_path(@post), success: 'Comentário não foi criado.' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      format.html { redirect_to post_path(@post), success: 'Comentário atualizado com sucesso.' }
      format.json { render :show, status: :created, location: @post }
    else
      format.html { redirect_to post_path(@post), alert: 'Comentário não foi atualizado.' }
      format.json { render json: @post.errors, status: :unprocessable_entity }
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
    params.require(:comment).permit(:body)
  end
end
