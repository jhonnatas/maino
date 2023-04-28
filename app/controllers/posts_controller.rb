class PostsController < ApplicationController
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

    create_or_delete_posts_tags(@post, params[:post][:tags])

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
    create_or_delete_posts_tags(@posts, params[:post][:tags])

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

  def import_txt
    #@response = ImportTxt.call(params[:arquivo], current_user)

    #unless @response
     # redirect_to posts_url, warning: 'Extensão inválida'
    #else 
     # redirect_to posts_url, success: 'Dados importados com sucesso!'
    #end
    
    saved_file = salve_on_disc(params[:arquivo])
    
    import_try = ImportJob.perform_async(saved_file, current_user)

    unless import_try
      redirect_to posts_url, warning: 'Extensão inválida'
    else 
     redirect_to posts_url, success: 'Dados importados com sucesso!'
    end
  end
  
  private

  def salve_on_disc(file)
    txt_file_path = "public/"
    file_name = "dados_#{Time.now.to_i}.txt"
    txt_file_path = File.join(Rails.root, txt_file_path, file_name)
    File.open(txt_file_path, "wb") do |f|
      f.write(file.read)
      f.close
    end
    file_name
  end

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
    params.require(:post).permit(:title, :description, :tags, :image, :user_id)
  end
end
