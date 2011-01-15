# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class MygengoExtension < Radiant::Extension
  version "0.2"
  description "myGengo service"
  url "http://github.com/shell/radiant-mygengo-extension"
  
  extension_config do |config|
    config.gem 'mugen'
    config.after_initialize do
      Mugen.api_key = ''
      Mugen.private_key = ''      
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
