class BugsController < ApplicationController
  before_action :varify_app

  def index
      @bugs = Bug.where(token:params['token'])
      render :json => {success: true, status: 200, bugs:@bugs }
  end

  def create
    @bug = Bug.generate_new_bug bug_params, state_params
    if @bug
      render :json => {success: true, status: 200, bug:@bug.as_json }
    else
      render :json => {success: false, status: 400, action:'create' }
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

  def bug_params
    params.require('bug').primit(:token, :priority)
  end
  
  def state_params
    params.require('state').primit(:devise, :os, :memory, :storage)
  end


end
