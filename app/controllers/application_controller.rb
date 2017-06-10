class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :varify_app



  
  ############
  private
  ###########
  def varify_app
    #need to make sure Token is present
    if params[:token].blank?
        render :json => { :error => "No Token Provided!", :status=>:unauthorized }
    end
  end
end
