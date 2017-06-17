module Api::V1

  class BugsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @bugs = (Api::V1::Bug.where(token:params['token'])).to_a.map! {|bug|  bug.bug_as_json}
        render :json => {success: true, status: 200, bugs:@bugs, api_version:params[:controller] }
    end

    def create
      if validate_bugs_params
        report_new_bug
      else
        render :json => {success: false, status: 400,params:params, message:'Invalid Params!' }
      end
    end

    def show
      @bug = Api::V1::Bug.find_by(  token:params['token'], number:params['number'])
      if @bug
        render :json => {success: true, status: 200, api_version:params[:controller], bug:@bug.bug_as_json }
      else
        render :json => {success: false, status: 404, message:"Not Found", number:params['number'], token:params['token'], bug:nil}
      end

    end

    def update
      render :json => {success: true, status: 200, action:'update', api_version:params[:controller]}
    end

    def destroy
      render :json => {success: true, status: 200, action:'destroy', api_version:params[:controller]}
    end
    
    ############
    protected
    ###########

    def validate_bugs_params
      bug = params['bug']
      state = params['state']
      return   bug.try(:[],:token).present? && (bug[:token] == params[:token]) && state.try(:[],:devise).present? && state[:os].present? && state[:memory].present? && state[:storage].present?
    end

    def bug_params
      params.require('bug').permit(:token, :priority, :comment)
    end

    def state_params
      params.require('state').permit(:devise, :os, :memory, :storage)
    end

    #find BugService in lib/bug_service.rb
    #find RabbitMg in intializers/bunny.rb
    def report_new_bug
      bug_num = BugService.set_new_bug bug_params['token']
      if bug_num
        new_bug_params =  bug_params
        new_bug_params['number'] = bug_num
        RabbitMg.send_message("{bug_params:#{new_bug_params.to_json},state_params:#{state_params.to_json}}")
        render :json => {success: true, status: 200, message:"will Report This Issue", bug:new_bug_params }
      else
        render :json => {success: false, status: 500, api_version:params[:controller], message:'Internal Error! .. Try Again' }
      end

    end


  end
end
