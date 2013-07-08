class Api::V1::EpsController < ApplicationController
  def show
    sources = Source.select("link").where("ep_id = #{params[:id]}").order("id ASC")

    render :json => sources.to_json
  end
end
