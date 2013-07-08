class Api::V2::EpsController < ApplicationController
  def show
    sources = SourceV2.select("link").where("ep_v2_id = #{params[:id]}").order("id ASC")

    render :json => sources.to_json
  end
end
