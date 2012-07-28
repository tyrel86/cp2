ActiveRecord::Base.class_eval do
    def self.validates_class_of(*attr_names)
        options = attr_names.extract_options!
        validates_each(attr_names, options) do |record, attribute, value|
          record.errors[attribute] << "Error: Class must be " + options[:class].to_s unless value.class == options[:class]
        end
    end
		
    def self.validates_zip_with_geo_code(*attr_names)
        options = attr_names.extract_options!
        validates_each(attr_names, options) do |record, attribute, value|
					unless record.kind_of? Geokit::Geocoders
						raise "In order to use validates_zip_code_with_geo_code you need to install the geokit gem and include Geokit::Geocoders in your model"
					end
					geo = MultiGeocoder.geocode( value.to_s )
					unless ( geo.state == record.state and geo.city == record.city )
          	record.errors[attribute] << "Zip code does not match city and state"
					end
        end
    end
end
