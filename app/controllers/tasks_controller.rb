class TasksController < ApplicationController
  
  before_filter :load_project
  
  def load_project
    @project = Project.find(params[:project_id])
    
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "There was an error finding the parent project"
    redirect_to projects_path
    
  end
  
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = @project.tasks.parents.paginate(:per_page => 30, :page => params[:page], :include => :project)
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id], :include => :tasks)
    @tasks = @task.tasks
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
    @task.parent = params[:parent].nil? ? nil : params[:parent]
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    params[:task][:project] = @project.id
    @task = Task.new(params[:task])

    if @task.save
      flash[:success] = 'Task was successfully created.'
      redirect_to project_task_path(@project, @task)
    else
      render :action => "new"
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    params[:task][:project] = @project
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:success] = 'Task was successfully updated.'
      redirect_to project_task_path(@project, @task) }
    else
      render :action => "edit" }
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
