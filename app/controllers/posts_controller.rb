class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    #@posts = Post.all.order('created_at')#.page params[:page]
    @posts = Post.where(user_id: current_user)
  end
  
  def show
  end
 
  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, success: 'Post foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, success: 'Post foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy    
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, success: 'Post foi deletado com sucesso.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end   

    # Only allow a list of trusted parameters through.
    def post_params
      params['post']['user_id'] = current_user.id
      params.require(:post).permit(:title, :description, :user_id)
    end
end
