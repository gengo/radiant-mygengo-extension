ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin| 
    admin.namespace :mygengo do |mygengo|
      mygengo.resources :jobs, :shallow => true, :member => {       
          :review_form => :get,
          :reject_form => :get,
          :revise_form => :get,
          :purchase    => :get,
          :reject      => :post, 
          :revise      => :post,
          :approve     => :post,  
          :callback    => :post,
      }  
      mygengo.resources :comments, :only => [:create]
      mygengo.resources :account, :only => [:index]
    end
    admin.resources :translations, :only => [:index, :create]
    admin.resources :mygengo, :as => 'mygengo', :only => [ :index ]    
  end
  map.resources :mygengo, :only => [ :index ]
  map.revision_admin_mygengo_job '/admin/mygengo/jobs/:job_id/revision/:id', :controller => 'mygengo/jobs', :action => 'revision'
  
end