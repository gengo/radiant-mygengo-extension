class Admin::Mygengo::AccountController < MygengoController
  before_filter :assets_global
  
  def index    
    mygengo_requests do 
      @account = Mugen::Account.balance || {}
      @stats = Mugen::Account.stats
    end             
   
    @account.merge! @stats if @stats
  end
  
  private 
    def assets_global
      include_stylesheet 'admin/extensions/mygengo/mugen'
    end
      
end