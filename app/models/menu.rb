class Menu
	def self.all
		return( [ { :name => 'Categories', :href => '/categories', :onclick => 'return(categories());' }, { :name => 'Contact', :href => '#' }, { :name => 'Sign in', :href => '/users/sign_in' } ] )
	end
end
