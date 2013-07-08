class SourceV2sController < ApplicationController


  def new
    @ep_id = params[:ep_v2_id]
  end

  def update
    @source = SourceV2.find(params[:id])
    if @source.update_attributes(params[:source_v2])
      redirect_to :controller => 'ep_v2s', :action => 'show', :id => @source.ep_v2_id
    else
      render :action => "edit" 
    end
  end

  def create
    @source = SourceV2.new(params[:source_v2])
    if @source.save
      redirect_to :controller => 'ep_v2s', :action => 'show', :id => @source.ep_v2_id
    else
      render :action => "new", :ep_v2_id => @source.ep_v2_id
    end
  end

  def edit
    @source = SourceV2.find(params[:id])
  end

  def destroy
    @source = SourceV2.find(params[:id])
    @source.destroy
    redirect_to :controller => 'ep_v2s', :action => 'show', :id => @source.ep_v2_id
  end
end
