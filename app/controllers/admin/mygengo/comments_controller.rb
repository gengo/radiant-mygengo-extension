class Admin::Mygengo::CommentsController < MygengoController
  def create                                       
    mygengo_requests do
      flag = Mugen::Job.create_comment(params[:id], params[:comment])
    end
    redirect_to admin_mygengo_job_path(params[:id])
  end
end