class Menu
	def self.all
		return( [ { :name => 'Categories', :href => '/categories', :onclick => 'return(categories());' }, { :name => 'Contact', :href => '#' } ] )
	end
end
