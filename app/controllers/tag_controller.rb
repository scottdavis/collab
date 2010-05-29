class TagController < ApplicationController

  TAGGABLE = %w(project task asset)

  def tag
    unless TAGGABLE.include? params[:type] 
      render :text => nil, :layout => false
      return
    end
    object = params[:type].classify.constantize.find(params[:id])
    object.tag_list = params[:value]
    if object.save
      render :text => params[:value], :layout => false
    else
      render :text => nil, :layout => false
    end
  end
  
  
end
