class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	before_action :set_post, only: %i[show edit update destroy]
	before_action :authorize_user!, only: %i[edit update destroy]
  
	def index
	  @posts = Post.all
	end
  
	def show
	end
  
	def new
	  @post = Post.new
	end
  
	def create
	  @post = current_user.posts.build(post_params)
	  if @post.save
		redirect_to posts_path, notice: "Post was successfully created."
	  else
		render :new
	  end
	end
  
	def edit
	end
  
	def update
	  if @post.update(post_params)
		redirect_to posts_path, notice: "Post was successfully updated."
	  else
		render :edit
	  end
	end
  
	def destroy
	  @post.destroy
	  redirect_to posts_path, notice: "Post was successfully destroyed."
	end
  
	private
  
	def set_post
	  @post = Post.find(params[:id])
	end
  
	def post_params
	  params.require(:post).permit(:title, :content, :answers_count)
	end
  
	def authorize_user!
	  redirect_to posts_path, alert: "Not authorized" unless @post.user == current_user
	end
  end
  