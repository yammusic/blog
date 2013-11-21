class PostsController < ApplicationController
	# load_resource :only => [:edit, :new, :create, :update, :destroy]
    skip_authorize_resource :only => [ :index, :show ]

	def index
		@categories = Categories.all
		if !params[:q].nil?
			@posts = Post.where("title LIKE '%#{params[:q]}%'").order("created_at DESC").pagination( params )
		else
			@posts = Post.order('created_at DESC').pagination( params )
		end

		respond_to do |format|
			format.html
			format.json { render( { :json => @posts } ) }
		end
	end

	def new
		@post = Post.new
		@categories = Category.order("name ASC")
	end

	def create
		@post = Post.new(params[:post])

		if @post.save
			redirect_to( mercury_editor_path( post_path( @post ) ) )
		else
			render( 'new' )
		end
	end

	def show
		@post = Post.find_by_params( params )

		if ( !params[ :mercury_frame ].nil? )
			authorize! :edit, @post
		end
	end

	def edit
		@post = Post.find_by_params( params )
	end

	def update
		@post = Post.find_by_params( params )

		if ( !params[ :content ].nil? )
			params[ :post ] = { 
				:title => params[ :content ][ :title ][ :value ],
				:description => params[ :content ][ :description ][ :value ],
				:text => params[ :content ][ :text ][ :value ]
			}
		end

		if ( @post.update_attributes( params[ :post ] ) )
			if ( request.xhr? )
				render( { :json => { :msg => 'Post edited successfully',:url => post_path(@post)}.to_json } )
			else
				redirect_to( @post )
			end
		else
			if ( request.xhr? )
				render( { :json => { :msg => 'Could not edit the post', :url => post_path(@post)}.to_json } )
			else
				render( 'edit' )
			end
		end
	end

	def destroy
		@post = Post.find_by_params( params )
		@post.destroy

		redirect_to( posts_path )
	end
end