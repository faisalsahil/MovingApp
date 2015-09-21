class ItemsController < ApplicationController
	before_action :authenticate_user!
	# before_action :check_user
	# before_action :set_project, only: [:edit, :update, :destroy, :detail_report]
	respond_to :html, :json, only: [:index, :new, :create, :edit, :update, :show, :destroy,:assign_project,:add_users,:reports,:users]

	def index
	
		@customer = Customer.find(params[:customer_id])
		@items = @customer.items.where(cn: true)
		respond_with @items
	end

	def new
		@customer = Customer.find(params[:customer_id])
		@item = @customer.items.build
		@count = @customer.items.count
		respond_with @item
	end

	def create
		customer = Customer.find(params[:customer_id])
		if params[:itemid].present?
			@item = Item.find(params[:itemid])
		else
			@item = customer.items.build
		end
		# @item.item_number = params[:item][:item_number]
		@count = customer.items.count
		@item.item_number = @count+1
		@item.article = params[:item][:article]
		@item.description_at_origin = params[:item][:description_at_origin]
		@item.driver = params[:item][:driver]
		@item.warehouse_cross = params[:item][:warehouse_cross]
		@item.warehouse = params[:item][:warehouse]
		@item.desr_symbole = params[:item][:desr_symbole]
		@item.shipper = params[:item][:shipper]
		@item.exception_symbol = params[:item][:exception_symbol]
		@item.location_symbol = params[:item][:location_symbol]
		@item.exception = params[:item][:exception]
		@item.file1 = params[:item][:file1]
		@item.file2 = params[:item][:file2]

		respond_to do |format|
			if @item.save
				@item.cn = true
				@item.save!
				customer.items.where(cn: false).destroy_all
				format.html { redirect_to customer_items_path(customer), success: "Item successfully created." }
		        format.json {  render json: :true}
			else
				format.html { render action: 'new' }
		        format.json { render json: :false}
			end
		end
	end


	def edit
		@item = Item.find(params[:id])
		@customer = Customer.find(params[:customer_id])
		@count = @customer.items.count
		respond_with @item
	end

	def update
		@customer = Customer.find(params[:customer_id])
		@item = Item.find(params[:id])
		@item.update_attributes(params_item)
		respond_to do |format|
			format.html { redirect_to customer_items_path(@customer), success: "Item successfully updated." }
	        format.json {  render json: :true}
		end
	end 

	def destroy
		@item = Item.find(params[:id])
		@customer = Customer.find(params[:customer_id])
		@item.destroy if @item.present?
		flash[:success] = "Successfully deleted."
		respond_to do |format|
			format.html { redirect_to customer_items_path(@customer), success: "Item successfully updated." }
	        format.json {  render json: :true}
		end
	end

	def show   # it is using to show details of the closed customer items
		@customer = Customer.find(params[:customer_id])
		@item = Item.find(params[:id])
		respond_with @item 
	end

	def upload_image   #upload image through app
		@customer = Customer.find(params[:customer_id])
		@item = Item.find(params[:id])
		# if params[:item][:itemId].present?
		# 	@item = Item.find(params[:itemId])
		# else
		# 	@item = @customer.items.build
		# end
		if params[:item][:file1].present?
			@item.file1 = uploaded_picture(params[:item][:file1]) if params[:item][:file1].present?
			@item.save!
			@url = @item.file1_url
		elsif params[:item][:file2].present?
			@item.file2 = uploaded_picture(params[:item][:file2]) if params[:item][:file2].present?
			@url = @item.file2_url
		end
		
		return render :json=>{url: @url}
	end

	def empty_item    # this function using only for mob app to create empty item
		@customer = Customer.find(params[:customer_id])
		@count = @customer.items.count
		item = @customer.items.build
		item.save!
		item.item_number = @count+1
		item.save!
		return render :json=> item
	end




	private

	def params_item
		params.require(:item).permit(:article,:item_number,:description_at_origin,:driver,:warehouse,:warehouse_cross,:shipper,:desr_symbole,:exception_symbol,:location_symbol,:file1,:file2,:exception)
	end

  	def uploaded_picture(base64)

	    tempfile = Tempfile.new ['upload', '.jpg']
	    tempfile.binmode
	    tempfile.write(Base64.decode64(base64))

	    # ActionDispatch::Http::UploadedFile.new(tempfile: tempfile,
	    #   filename: 'upload.jpg')
		tempfile
	end

end
