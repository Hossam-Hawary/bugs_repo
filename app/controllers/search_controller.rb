class SearchController < ApplicationController
  skip_before_action :varify_app
  def search
  if params[:q].nil?
    @bugs = []
  else
    @bugs = Api::V1::Bug.search_by_field params[:q], "comment"
  end
end
end
