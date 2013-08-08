class Api::V2::AppprojectsController < ApplicationController
  def index
    appprojects = Appproject.select("id,name,iconurl,pack,clas")

	render :json => appprojects
		
  end

  def promotion_info
    promotions = Appproject.select("name,iconurl,pack,clas,promo_title,content")
    n ={}
    response = []
    n["probability"] = 4
    n["promotions"] = promotions
    response << n

    
  	render :json => n.to_json
  end	

end
