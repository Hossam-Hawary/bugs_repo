class BugsController < ApplicationController

  def index
    render :json => {success: true, status: 200, action:'index', controller:'bugs' }
  end

  def create
    render :json => {success: true, status: 200, action:'create', controller:'bugs' }
  end

  def show
    render :json => {success: true, status: 200, action:'show', controller:'bugs'}
  end

  def update
    render :json => {success: true, status: 200, action:'update', controller:'bugs'}
  end

  def destroy
    render :json => {success: true, status: 200, action:'destroy', controller:'bugs'}
  end

end
