class BugsController < ApplicationController
  before_action :varify_app
  skip_before_action :verify_authenticity_token

  def index
      @bugs = Bug.where(token:params['token'])
      render :json => {success: true, status: 200, bugs:@bugs }
  end

  def create
    if validate_bugs_params
      RabbitMg.send_message("{bug_params:#{bug_params.to_json},state_params:#{state_params.to_json}}")
      render :json => {success: true, status: 200, message:"will Report This Issue" }
    else
      render :json => {success: false, status: 400, action:'create',params:params, message:'Missing Params' }
    end
  end

  def show
    @bug = Bug.find_by( number:params['number'], token:params['token'])
    if @bug
      render :json => {success: true, status: 200, bug:@bug.as_json }
    else
      render :json => {success: false, status: 400, number:params['number'], token:params['token'], bug:'Not_found'}
    end

  end

  def update
    render :json => {success: true, status: 200, action:'update', controller:'bugs'}
  end

  def destroy
    render :json => {success: true, status: 200, action:'destroy', controller:'bugs'}
  end
  ############
  private
  ###########
  def varify_app
    #need to make sure Token is present
  end

  def validate_bugs_params
    bug = params['bug']
    state = params['state']
    return bug.present? && state.present? && bug['token'].present? && state['devise'].present? && state['os'].present? && state['memory'].present?  && state['storage'].present?
  end

  def bug_params
    params.require('bug').permit(:token, :priority)
  end

  def state_params
    params.require('state').permit(:devise, :os, :memory, :storage)
  end


end
