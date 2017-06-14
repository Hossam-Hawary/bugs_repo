module Api::V1

  class SearchController < ApplicationController
    skip_before_action :varify_app
    def search
      if params[:key].blank?
      render :json => {success: false, status: 400, message:" No Keyword Provided for search!", bugs:[] }
      else
        bugs =  params[:field].present? ? ( Api::V1::Bug.search_by_field params[:key], params[:field]) : (Api::V1::Bug.search params[:key])
        render :json => {success: true, status: 200, bugs:bugs.to_a.map! {|bug| bug['_source']}}
      end
    end

    def search_obj_as_json(object)
      {
        'number' => object['number'],
        'status' => object['status'],
        'priority' => object['priority'],
        'token' => object['token'],
        'comment' => object['comment']
      }
    end
  end
end
