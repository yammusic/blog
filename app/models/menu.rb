class Menu
	def self.all
		return( [ { :name => 'Categories', :href => 'javascript:void(0)', :onclick => 'categories()' }, { :name => 'Contact', :href => '#' } ] )
	end
end
