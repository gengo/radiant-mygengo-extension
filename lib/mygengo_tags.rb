module MygengoTags
  include Radiant::Taggable

  desc %{ outputs the body_src of given translation }
  tag "translation_src" do |tag|
    id = tag.attr['id']        
    trs = get_translation(id)    
    if trs
      trs.body_src
    else
      "N/A"
    end
  end

  desc %{ outputs the body_tgt of given translation }
  tag "translation_tgt" do |tag|
    id = tag.attr['id']        
    trs = get_translation(id)    
    if trs
      trs.body_tgt
    else
      "N/A"
    end
  end

  desc %{ outputs summary of given translation }
  tag "translation_summary" do |tag|
    id = tag.attr['id']        
    trs = get_translation(id)    
    if trs
      "Translation(##{trs.id}): #{trs.body_tgt[0..50]}, #{trs.lc_src} &raquo; #{trs.lc_tgt}"
    else
      "N/A"
    end
  end
   
  desc %{ outputs list of last 10 translations }
  tag "translation_list" do |tag|
    trs = MygengoTranslation.all(:limit => 10)
    html = "<h3>Translations</h3><ul>"
    html += trs.collect {|tr| "<li>ID ##{tr.id}, #{tr.lc_src} &raquo; #{tr.lc_tgt}</li>"}.join('')
    html += "</ul>"
    html
  end 
  
  
  private 
    def get_translation(id)
      begin
        trs = MygengoTranslation.find(id)
      rescue
        trs = nil
      end
      trs
    end
end