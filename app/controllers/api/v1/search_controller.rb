module Api::V1

  class SearchController < ApplicationController
    def search
      if params[:key].present? && params[:field].present?
        begin
          bugs = Api::V1::Bug.search_by_field params[:token], params[:key], params[:field]
          bugs.records.to_a.map! {|bug| bug.bug_as_json}
          render :json => {success: true, status: 200, api_version:params[:controller], bugs:bugs}
        rescue  Elasticsearch::Transport::Transport::Errors::BadRequest
              render :json => {success: false, status: 400, message:" Not Valid keys for search!",api_version:params[:controller]}
        end
      else
        render :json => {success: false, status: 400, message:" No Keyword or field Provided for search!",api_version:params[:controller]}
      end
    end

  end
end
