class Admin::Mygengo::AccountController < ApplicationController
  # layout 'mygengo'
  helper :mugen
  before_filter :assets_global
  
  def index    
    @account = Mugen::Account.balance || {}
    @stats = Mugen::Account.stats
    @account.merge! @stats if @stats
  end
  
  private 
    def assets_global
      include_stylesheet 'admin/extensions/mygengo/mugen'
    end
      
end