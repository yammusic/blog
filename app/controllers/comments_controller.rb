class CommentsController < ApplicationController
	    skip_authorize_resource :only => [ :destroy ]


	def create
		@post = Post.find_by_params_has( params )
		@comment = @post.comments.create( params[ :comment ] )
		redirect_to( post_path( @post ) )
	end

	def destroy
		@post = Post.find_by_params_has( params )
		@comment = @post.comments.find( params[ :id ] )
		@comment.destroy
		redirect_to( post_path( @post ) )
	end
end
