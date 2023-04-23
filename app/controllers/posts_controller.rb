class PostsController < ApplicationController  
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false

  def index
    @posts = Post.by_recently_created.where(user_id: current_user).page params[:page]
  end
  
  def show
    @comments = @post.comments.order(created_at: :desc)
  end
 
  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params.except(:tags))

    create_or_delete_posts_tags(@post, params[:post][:tags],)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_path(@post), success: 'Post foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    create_or_delete_posts_tags(@posts, params[:post][:tags],)

    respond_to do |format|
      if @post.update(post_params.except(:tags))
        format.html { redirect_to post_path(@post), success: 'Post foi atualizado com sucesso.' }
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

  def create_or_delete_posts_tags(post, tags)
    post.taggables.destroy_all
    tags = tags.strip.split(",")
    tags.each do |tag|
      post.tags << Tag.find_or_create_by(name: tag)
    end
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def post_params
    params['post']['user_id'] = current_user.id
    params.require(:post).permit(:title, :description, :tags, :user_id)
  end
end
