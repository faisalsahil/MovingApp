class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  after_action :set_access_control_headers
  def authenticate_user!
    if params[:authenticity_token].present?
      token = Token.find_by_api(params[:authenticity_token])

      if token.present? and token.user.present?
        sign_in(token.user)
        return
      end
    end
    super
  end
# def handle_options_request
#     head(:ok) if request.request_method == "OPTIONS"
# end

  def set_access_control_headers
    # headers['Access-Control-Allow-Origin'] = '*'
    # headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    # headers['Access-Control-Allow-Origin'] = '*' 
    # headers['Access-Control-Request-Method'] = '*'
    # if request.method == "OPTIONS" || request.method == "options"
      # headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
      # headers['Access-Control-Allow-Origin'] = "http://localhost:9000"
      # headers['Access-Control-Allow-Origin'] = "*"
      
      # headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      # headers['Access-Control-Request-Method'] = '*'
      # headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      # headers['Access-Control-Allow-Origin'] = '*'

      # headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      # headers['Access-Control-Max-Age'] = '1000'
      # headers['Access-Control-Allow-Headers'] = '*, Origin, X-Requested-With, Content-Type, Accept'
      
      # return (head :ok)
    # end
  end

  protected

  def stored_location_for(resource)
    nil
  end

  def admin_or_client_only
    if current_user.admin? || current_user.client?
    else
      return redirect_to root_path 
    end
  end
end
