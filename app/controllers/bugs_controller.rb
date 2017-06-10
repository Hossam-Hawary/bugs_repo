class BugsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
      @bugs = Bug.where(token:params['token'])
      render :json => {success: true, status: 200, bugs:@bugs }
  end

  def create
    if validate_bugs_params
      report_new_bug
    else
      render :json => {success: false, status: 400, action:'create',params:params, message:'Missing Params' }
    end
  end

  def show
    @bug = Bug.find_by( number:params['number'], token:params['token'])
    if @bug
      render :json => {success: true, status: 200, bug:@bug.as_json }
    else
      render :json => {success: false, status: 404, message:"Not Found", number:params['number'], token:params['token'], bug:nil}
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

  def report_new_bug
    bug_num = BugService.set_new_bug bug_params['token']
    new_bug_params =  bug_params
    new_bug_params['number'] = bug_num
    RabbitMg.send_message("{bug_params:#{new_bug_params.to_json},state_params:#{state_params.to_json}}")
    render :json => {success: true, status: 200, message:"will Report This Issue", bug:new_bug_params }
  end


end
