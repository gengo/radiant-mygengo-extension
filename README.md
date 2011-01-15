# Radiant myGengo Extension

  This extension provides integration between RadiantCMS and myGengo.com through API

## Installation

  Create new radiant project
  
    $ radiant some_site
    $ rake db:bootstrap
    $ gem install mugen
    
  In some_site directory do
    
    $ ./script/extension install mygengo
    $ rake radiant:extensions:mygengo:migrate
    $ rake radiant:extensions:mygengo:update
    
  Paste API keys in ./vendor/extensions/mygengo/mygengo_extension.rb
  
    extension_config do |config|
      config.gem 'mugen'
      config.after_initialize do
        Mugen.api_key = ''
        Mugen.private_key = ''      
      end
    end
    
  Start server and enjoy!     
  
### Support Rake tasks  

  Next tasks can be useful for maintenance or installation:
  
  * _rake radiant:extensions:mygengo:migrate_ - Runs the migration of the Mygengo extension
  * _rake radiant:extensions:mygengo:sync_ - Syncs all available translations for this ext to the English ext master
  * _rake radiant:extensions:mygengo:update_ - Copies public assets of the Mygengo to the instance public/ directory.

## Usage                                

  Extension adds 'myGengo' tab in admin panel, with following sub-tabs:
  
  * Jobs - list of translation jobs on myGengo
  * Account - account information
  * Translations - local translation records
  
  Local translations allow you store successfully translated texts in local database, this will increase page rendering speed. When job has been approved you can create local translation record in your database and show it on any page with radius-tags 

### Radius-Tags

* _<r:translation_list />_ - prints list of last 10 translations
* _<r:translation_src id="1"/>_ - prints body_src of given translation
* _<r:translation_summary id="2"/>_ - prints summary of given translation
* _<r:translation_tgt id="3"/>_ - prints the body_tgt of given translation

## TODO    

* in progress

## Author
Copyright (c) 2011 Vladimir Penkin
