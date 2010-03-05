namespace :db do
  namespace :factory do
    desc "Load the factory data"
    task :load => [:environment, :load_class] do
      FactoryLoader.up
    end
    desc "Unload all the stories"
    task :unload => [:environment, :load_class] do
      FactoryLoader.down
    end
    desc "Reload Factories"
    task :reload => [:environment, :load_class, :unload, :load] 
    
    task :load_class do
      require File.join(RAILS_ROOT, 'factories', 'factory_loader')
    end
  end
end