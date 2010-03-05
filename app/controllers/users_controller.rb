class UsersController < Clearance::UsersController
  
  def dashboard
    @user = current_user
    @projects = @user.projects.active.paginate(:per_page => 30, :page => params[:page])
  end
  
  def show
    @user = User.find_by_short_name(params[:id])
  end
  
  def inline
    
    user = current_user
    old = user.send(params[:id])
    user.update_attribute(params[:id], params['value'])
    if user.save
      value = user.send(params[:id])
    else
      value = old
    end
    render :text => value , :layout => false
  end
  
end