class AdilasHelper

	def initialize( corperate_key )
  	@key = corperate_key
		@client = Savon.client("http://www.adilaswebservices.biz/inventory/webComponents/adilasWeb.cfc?wsdl")
		@live_menu = requestLiveMenu
	end

	def request( action_as_sym, params = {} )
		params[:corp_key_id] = @key
		request = @client.request( :web, action_as_sym ) do
			soap.body = params
		end
	end

	def getCatHash
		@category_hash
	end

	def requestLiveMenu
		request_product_type_id_hash
		@category_hash = {}
		@product_type_id_hash.each do |key, value|
			add_productucs_for_cat( value, key )
		end
	end

	def request_product_type_id_hash
		r = request(:getAllPartsCategories)
		array = r.to_array[0][:get_all_parts_categories_response][:get_all_parts_categories_return][:item][3][:value][:data][:data]
		@product_type_id_hash = {}
		array.each do |e|
			@product_type_id_hash[e[:data][1]] = e[:data][0]
		end
	end

	def add_productucs_for_cat( cat_id, cat_name )
		r = false
		begin
			r = request( :getWebGeneralInventory, { part_category_id: cat_id } )
		rescue Savon::HTTP::Error
			puts "HTTP failure alert the NSA.. or some one imediatly"
		end
		if r and ( r.to_array[0][:get_web_general_inventory_response][:get_web_general_inventory_return][:item][0][:value].to_i > 0 )
			cols = r.to_array[0][:get_web_general_inventory_response][:get_web_general_inventory_return][:item][2][:value][:column_list][:column_list]
			products = r.to_array[0][:get_web_general_inventory_response][:get_web_general_inventory_return][:item][2][:value][:data][:data]
			if products.class == Array
				products = products[0][:data]
			end
			if products.class == Hash
				products = products[:data]
			end
			cat_hash = {}
			cols.each_with_index do |element, index|
				cat_hash[element] = products[index]
			end
			@category_hash[cat_name] = cat_hash
		end
	end

end
