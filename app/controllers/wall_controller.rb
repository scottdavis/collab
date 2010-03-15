class WallController < ApplicationController
  before_filter :authenticate, :load_project
  
  def create
    @wall = Wall.new(params[:wall])
    @wall.project = @project
    @wall.author = current_user
    @wall.save
  end
  
  
private  
  
  def load_project
    @project = Project.find(params[:project_id])
  end
  
end
