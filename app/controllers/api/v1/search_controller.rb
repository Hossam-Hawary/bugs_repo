module Api::V1

  class SearchController < ApplicationController
    def search
      if params[:key].present? && params[:field].present?
        bugs = Api::V1::Bug.search_by_field params[:token], params[:key], params[:field]
        render :json => {success: true, status: 200, bugs:bugs.to_a.map! {|bug| bug['_source']}}
      else
        render :json => {success: false, status: 400, message:" No Keyword or field Provided for search!", bugs:[] }
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
