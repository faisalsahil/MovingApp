json.customer do |json|
  json.id  @customer.id
  json.name @customer.name
end


json.items do |json|
	json.array!(@items) do |json,item|
	  json.id item.id
	  json.item_number item.item_number
	  json.article item.article
	  json.description_at_origin item.description_at_origin
	  json.warehouse_cross item.warehouse_cross
	  json.driver item.driver
	  json.warehouse item.warehouse
	  json.shipper item.shipper
	  json.exception item.exception
	  json.desr_symbole item.desr_symbole
	  json.exception_symbol item.exception_symbol
	  json.file1 item.file1.url
	  json.file2 item.file2.url
	end
end
