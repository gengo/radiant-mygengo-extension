# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class MygengoExtension < Radiant::Extension
  version "0.2.1"
  description "myGengo service"
  url "http://github.com/shell/radiant-mygengo-extension"
  
  extension_config do |config|
    config.gem 'mugen'
    config.after_initialize do
      Mugen.api_key = '6NO~NtyavKh@x-Uz@)0LG_PQ1KJI[(kd_2{oqv}H{ubO5Yu3is~IF^udRwM6QC6n'
      Mugen.private_key = 'w0F((zYj3=09(AD|2B7)jNT@5F[wajwk[6u^stF59wCfuCtwMEMB^c7y=5V~WM^K'      
    end
  end

  def activate
    tab "myGengo" do
      add_item "Jobs",    "/admin/mygengo/jobs"
      add_item "Account", "/admin/mygengo/account"
      add_item "Translations", "/admin/translations"
    end
    
    Page.send :include, MygengoTags
    
  end
end
