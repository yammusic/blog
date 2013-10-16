class PostsController < ApplicationController
	http_basic_authenticate_with :name => '123', :password => 'abc', :except => [:index, :show]

	def index
		@categories = Categories.all
		if defined?(params[:q]) && !params[:q].nil?
			@posts = Post.where("title LIKE '%#{params[:q]}%'")
		else
			@posts = Post.all
		end
		respond_to do |format|
			format.html
			format.json { render( { :json => @posts } ) }
		end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params[:post])

		if @post.save
			redirect_to( @post )
		else
			render( 'new' )
		end
	end

	def show
		@post = Post.find(params[:id])
		@tag = Tag.new
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update_attributes(params[:content])
			redirect_to( @post )
		else
			render( 'edit' )
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to( posts_path )
	end

	def mercury_update
		@post = Post.find(params[:id])

		if @post.update_attributes(params[:content])
			redirect_to( @post )
		else
			render( 'edit' )
		end
	end
end
