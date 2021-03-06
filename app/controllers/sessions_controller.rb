class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create, :new ]
  
  # before_filter :ensure_params_exist, only: [:create]
 
  respond_to :json, :html
  def create
    if request.method == "options" || request.method=="OPTIONS"
      render :nothing => true, :status => 200
      return 
    end
    email = ""
    password = ""
    if request.format == "json"
      email = params[:data][:user][:email] 
      password = params[:data][:user][:password] 
    else
      email = params[:user][:email]
      password = params[:user][:password]
    end

    resource = User.find_for_database_authentication(email: email) 
    
    # return invalid_login_attempt unless resource
 
    if resource && resource.valid_password?(password)
      sign_in(resource)
      random = SecureRandom.hex
      resource.tokens << Token.create!(api: random)
      respond_to do |format|
	        format.html { redirect_to root_path}
	        format.json { render :json=> {user: resource, authenticity_token: random }}
	    end
      # puts "SUCCESS"*30
      return
    else
      respond_to do |format|

        format.html {  
          flash[:alert] =  "Error with your login or password"
          redirect_to :back
        }
        format.json { render :json=> invalid_login_attempt}
      end
    end
    # invalid_login_attempt
  end
  # def create
  #   resource = User.find_for_database_authentication(:email=>params[:user][:email])
  #   return invalid_login_attempt unless resource
 
  #   if resource.valid_password?(params[:user][:password])
  #     sign_in("user", resource)
  #   respond_to do |format|
  #         format.html { redirect_to root_path}
  #         format.json { render :json=> resource }
  #     end
  #     return
  #   end
  #   invalid_login_attempt
  # end
  
  def destroy
    sign_out(resource_name)
    resource.try(:tokens).try(:destroy_all)
    
    respond_to do |format|
	        format.html { redirect_to root_path}
	        format.json { render :json=> resource }
	    end
    
  end
 
  protected
  def ensure_params_exist
    return unless params[:user].blank?
	respond_with resource, status: 404
  end
 
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>200
  end
end
