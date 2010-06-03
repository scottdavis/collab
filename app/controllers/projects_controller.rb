class ProjectsController < ApplicationController
  before_filter :authenticate
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.active.paginate :per_page => 30, :page => params[:page]
  end
  
  def join
    @project = Project.find(params[:project_id])
    @project.users << current_user
    if @project.save
      flash[:success] = "You have joined #{@project.name}"
    else
      flash[:error] = "There was a problem joining this project"
    end
    redirect_to project_path(@project)
  end

  def leave
    @project = Project.find(params[:project_id])
    @project.users.delete current_user
    if @project.save
      flash[:success] = "You have been removed from #{@project.name}"
    else
      flash[:error] = "There was an error removing you form this project"
    end
    redirect_to project_path(@project)
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id], :include => [:users, :wall_posts])
    @tasks = @project.tasks.parents.paginate(:per_page => 30, :page => params[:page], :include => :tasks)
    @wall_posts = @project.wall_posts.paginate(:per_page => 15, :page => params[:post_page])
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:notice] = 'Project was successfully created.'
      format.html { redirect_to(@project) }
    else
      format.html { render :action => "new" }
    end

  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
