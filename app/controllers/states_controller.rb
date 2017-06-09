class StatesController < ApplicationController

  def index
    render :json => {success: true, status: 200, action:'index', controller:'states' }
  end

  def create
    render :json => {success: true, status: 200, action:'create', controller:'states'}
  end

  def show
    render :json => {success: true, status: 200, action:'show', controller:'states'}
  end

  def update
    render :json => {success: true, status: 200, action:'update', controller:'states'}
  end

  def destroy
    render :json => {success: true, status: 200, action:'destroy', controller:'states'}
  end

end
