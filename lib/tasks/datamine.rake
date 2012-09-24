namespace :datamine do

	desc "Fetches data from xml and parses into mysql"
	task riseup: :environment do

		def getMetaValueForKey( listing, search_key )
			postMetas = listing.find("wp:postmeta")
			
			postMeta = postMetas.select do |pm|
				pm_key = pm.find('wp:meta_key').first.entries.first.content
				search_key == pm_key
			end
			postMeta.first ? postMeta.first.find('wp:meta_value').first.entries.first.content : nil
		end

		def formatPhone( number )
			if number
				number = number.gsub(/[^0-9]/, '')
				number[0..9]
			end
		end

		state_mappings = {'CO' => "Colorado", 'AZ' => 'Arizona', 'CA' => 'California', 'MI' => "Michigan",
											'NV' => 'Nevada'}

		type_mappings = { 'Lawyer' => 'Kind Lawyer', 'Doctor' => 'Kind Doctor', 'Grow Stores' => 'Grow Store',
											'Dispensary/Medical Marijuana Center' => 'Dispensary', 'Smoke Shop' => 'Smoke Shop',
											'Grow Consultants' => 'Grow Consultant' }

		# root_dir = "/home/CannaPages/db/xmlDumps/"
		root_dir = "/home/tyrel/code/ruby/rails/CannaPages/db/xmlDumps/"
		
		states_array = ['arizona','colorado','california','michigan','nevada']
		states_array.each do |state|
			puts "Starting #{state}"
			full_path = root_dir + state + ".xml"
			raw_xml = open( full_path ).read
			source = XML::Parser.string( raw_xml )
			content = source.parse
			listings = content.find("//item")
			listings.each do |listing|
				#Get virtual attributes
				name = listing.find('title').first.entries.first.content
				street_address = "#{getMetaValueForKey(listing, "buildingNumber")} #{getMetaValueForKey(listing, "line1")}"
				city = getMetaValueForKey(listing, "city")
				state = state_mappings[ getMetaValueForKey(listing, "state") ]
				zip_code = getMetaValueForKey(listing, "postalCode")
				phone = formatPhone( getMetaValueForKey(listing, "phone") )
				type = listing.find('category').first.content if listing.find('category').first 
				type = type_mappings[ type ]

				#Create virtual model
				dispensary = Dispensary.new( name: name, street_address: street_address, city: city, state: state,
																		 zip_code: zip_code, phone_number: phone, business_type: type, glass_sale: false,
																		 whole_sale: false, match_coupons: false )

				unless dispensary.business_type == :unclasified
					unless dispensary.save
						#Make note of failur
						File.open("/home/missing_listings.txt", 'w') { |file| file.write("#{dispensary.name} - #{phone_number}") }
					end
				end

			end
		end
	end

end
