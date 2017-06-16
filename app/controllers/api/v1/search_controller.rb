module Api::V1

  class SearchController < ApplicationController
    def search
      if params[:key].present? && params[:field].present?
        bugs = Api::V1::Bug.search_by_field params[:token], params[:key], params[:field]
        render :json => {success: true, status: 200, bugs:bugs.records.to_a.map! {|bug| bug.bug_as_json}}
      else
        render :json => {success: false, status: 400, message:" No Keyword or field Provided for search!", bugs:[] }
      end
    end

  end
end
