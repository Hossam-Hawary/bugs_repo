  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :varify_app
    skip_before_action :varify_app , only: [:home]

    def home
      render :home
    end


    ############
    private
    ###########
    def varify_app
      #need to make sure Token is present
      if params[:token].blank?
          render :json => { :message => "No Token Provided!", :status=>:unauthorized }
      end
    end
  end
