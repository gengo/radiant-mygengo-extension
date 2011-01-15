class Admin::TranslationsController < ApplicationController
  def index
    @translations = MygengoTranslation.all    
  end    
  
  def create    
    job_id = params[:translation][:job_id]
    @job = Mugen::Job.find(job_id)
    @translation = MygengoTranslation.new({:body_src => @job['body_src'],
                                    :body_tgt => @job['body_tgt'],
                                    :lc_src => @job['lc_src'],
                                    :lc_tgt => @job['lc_tgt'],
                                    :job_id => @job['job_id'] 
                                  })
    @translation.save!                             
    redirect_to admin_mygengo_jobs_path
  end
end
