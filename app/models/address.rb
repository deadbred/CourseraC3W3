class Address
	attr_accessor :city, :state, :location

	def initialize(city = nil , state = nil, location = nil)
		@city = city
		@state = state
		@location = Point.new(location[:coordinates][0], location[:coordinates][1]) if location.present?
	end

	def mongoize
		return { :city=> @city, :state=>@state, :loc=>{:type=>"Point", :coordinates=> [@location.longitude, @location.latitude]}}
	end

	def self.mongoize(object)
		case object
		when Hash then Address.new(object[:city], object[:state], object[:loc]).mongoize
		when Address then object.mongoize
		when nil then nil
		end
	end

	def self.demongoize(object)
		case object
	    when nil then nil
	    when Hash then Address.new(object[:city], object[:state], object[:loc])
	    else object
		end
	end

	def self.evolve(object)
		mongoize(object)
	end
end