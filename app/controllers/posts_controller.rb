 class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]


  def index
    @posts = Post.all #start an instance variable.
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params) #creating private methods to handle strong params
    @post.creator = User.first #TODO: Change once we have authentication. for now, new posts will be set to the first user.

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update    
    if @post.update(post_params)
      flash[:notice] = "This post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
    #strong params through require that only permits the following actions above.
    #use binding pry to check the submission details.
  end

  def set_post
    @post = Post.find(params[:id])    
  end

end
