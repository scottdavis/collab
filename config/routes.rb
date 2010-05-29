ActionController::Routing::Routes.draw do |map|
  Clearance::Routes.draw(map)
  map.user '/users/:id', :controller => :users, :action => :show
  map.user_inline_edit '/users/:id/inline', :controller => :users, :action => :inline, :conditions => { :method => :post }
  map.join_project '/projects/:project_id/join', :controller => :projects, :action => :join, :conditions => {:method => :post}
  map.leave_project '/projects/:project_id/leave', :controller => :projects, :action => :leave, :conditions => {:method => :delete}
  #map.dashboard '/dashboard', :controller => :users, :action => :dashboard

  map.update_tags '/tag/:type/:id', :controller => :tag, :action => :tag, :conditions => {:method => :post }
  
  map.resources :projects do |projects|
    projects.resources :tasks
    projects.resources :wall
  end


  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  map.root :controller => :users, :action => :dashboard
end
