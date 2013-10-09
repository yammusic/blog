class TagsController < ApplicationController
	http_basic_authenticate_with :name => "admin", :password => "123", :only => [:destroy, :create]

	def index
		@post = Post.find(params[:post_id])
		@tags = @post.tags.all
		respond_to do |format|
			format.html
			format.json { render( { :json => @tags } ) }
		end
	end

	def edit
		@post = Post.find(params[:post_id])
		@tag = @post.tags.find(params[:id])
	end

	def create
		@post = Post.find(params[:post_id])
		@tag = @post.tags.create(params[:tag])
		redirect_to( post_path(@post) )
	end

	def update
		@post = Post.find(params[:post_id])
		@tag = @post.tags.find(params[:id])

		if @tag.update_attributes(params[:tag])
			redirect_to( post_tags_path )
		else
			render( 'edit' )
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@tag = @post.tags.find(params[:id])
		@tag.destroy
		redirect_to( post_path(@post) )
	end
end
