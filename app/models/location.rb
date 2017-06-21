class Location < ApplicationRecord
	def self.search(search)
		if search
			find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		else
			nil
		end
	end
end
