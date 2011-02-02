class Admin::Mygengo::JobsController < MygengoController
  URL_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  before_filter :assets_global
  
  # GET /jobs
  # GET /jobs.xml
  def index
    mygengo_requests do 
      @job_ids = Mugen::Jobs.all
      @jobs = @job_ids.collect {|j| 
        Mugen::Job.find(j['job_id']).merge('comments' => Mugen::Job.comments(j['job_id']))
      }
    end
    @translation_ids = MygengoTranslation.all.collect {|t| t.job_id.to_s}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show      
    mygengo_requests do
      @job = Mugen::Job.find(params[:id])
      @preview = Mugen::Job.preview(@job['job_id'])
      @comments = Mugen::Job.comments(@job['job_id']) 
      @job.merge!('comments' => @comments)    
      @feedback = Mugen::Job.feedback(@job['job_id'])
      @revisions = Mugen::Job.revisions(@job['job_id'])
      @revisions = [@revisions] if @revisions.is_a?(Hash)
    end  

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end  
  
  def review_form
    mygengo_requests do
      @job = Mugen::Job.find(params[:id])
      @preview = Mugen::Job.preview(@job['job_id'])
      @comments = Mugen::Job.comments(@job['job_id']) 
      @job.merge!('comments' => @comments)        
      @feedback = Mugen::Job.feedback(@job['job_id'])    
    end
  end

  def reject_form
    mygengo_requests do
      @job = Mugen::Job.find(params[:id])
      @preview = Mugen::Job.preview(@job['job_id'])
      @comments = Mugen::Job.comments(@job['job_id']) 
      @job.merge!('comments' => @comments)        
    end
  end

  def revise_form
    mygengo_requests do
      @job = Mugen::Job.find(params[:id])
      @preview = Mugen::Job.preview(@job['job_id'])
      @comments = Mugen::Job.comments(@job['job_id']) 
      @job.merge!('comments' => @comments)        
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def revision
    mygengo_requests do
      @job = Mugen::Job.find(params[:job_id])    
      @revision = Mugen::Job.revision(params[:job_id], params[:id])
    end
    
    respond_to do |format|
      format.html {}
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    mygengo_requests do
      @job = Mugen::Job                                                    
      @languages = Mugen::Service.languages
      @language_pairs = Mugen::Service.language_pairs
      @language_src = @languages.collect { |lp| [ lp["language"], lp['lc'] ] }.uniq.sort
      @language_tgt = @languages.collect { |lp| [ lp["language"], lp['lc']  ] }.uniq.sort
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    mygengo_requests do
      @job = Mugen::Job.find(params[:id])
    end
  end

  # POST /jobs
  # POST /jobs.xml
  def create                                                     
    params[:job] = sanitize(params[:job])
    if params[:job]['callback_url'].empty? || 
       !params[:job]['callback_url'].match(URL_REGEXP)
      params[:job].delete('callback_url') 
    end
    
    mygengo_requests do
      
      flag = Mugen::Job.create(params[:job])    
    end
    redirect_to admin_mygengo_jobs_path
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update    
    mygengo_requests do
      @job = Mugen::Job.update(params[:id])
    end
    
    redirect_to admin_mygengo_jobs_path
  end             
  
  def purchase
    mygengo_requests do
      @job = Mugen::Job.purchase(params[:id])
    end
    
    redirect_to admin_mygengo_jobs_path
  end

  def approve
    mygengo_requests do
      @job = Mugen::Job.approve(params[:id])
    end
    
    redirect_to admin_mygengo_jobs_path
  end

  def revise
    mygengo_requests do
      @job = Mugen::Job.revise(params[:id], params[:job])
    end
    
    redirect_to admin_mygengo_jobs_path
  end

  def reject
    mygengo_requests do
      @job = Mugen::Job.reject(params[:id], params[:job])
    end
    
    redirect_to admin_mygengo_jobs_path
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    mygengo_requests do
      @job = Mugen::Job.delete(params[:id])
    end
    
    respond_to do |format|
      format.html { redirect_to(admin_mygengo_jobs_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
    def sanitize(opts)      
      opts['body_src'] = opts['body_src'].gsub(/<\/?.*?>/, "")
      return opts
    end
    
    def assets_global
      include_stylesheet 'admin/extensions/mygengo/mugen'
      include_stylesheet 'admin/extensions/mygengo/scaffold'
    end
    
end