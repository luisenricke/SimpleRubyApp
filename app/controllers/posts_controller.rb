class PostsController < ApplicationController
  before_action :redirect_if_not_signed_in, only: [:new]
  def index
    @hobby_posts = Post.by_branch('hobby').limit(8)
    @study_posts = Post.by_branch('study').limit(8)
    @team_posts = Post.by_branch('team').limit(8)
  end

  def show
    @post = Post.find(params[:id])
  end

  def hobby
    posts_for_branch(params[:action])
  end

  def study
    posts_for_branch(params[:action])
  end

  def team
    posts_for_branch(params[:action])
  end

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  def edit
    @categories = Category.all
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def get_posts
    PostsForBranchService.new({
                                search: params[:search],
                                category: params[:category],
                                branch: params[:action]
                              }).call
  end

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = get_posts.paginate(page: params[:page])
  end

  def post_params
    params.require(:post).permit(:content, :title, :category_id)
          .merge(user_id: current_user.id)
  end
end
