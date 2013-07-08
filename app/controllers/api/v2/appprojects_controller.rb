class Api::V2::AppprojectsController < ApplicationController
  def index
    appprojects = Appproject.select("id,name,iconurl,pack,clas")

	render :json => appprojects
		
  end	
end
