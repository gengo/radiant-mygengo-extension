class Admin::Mygengo::CommentsController < ApplicationController
  helper :mugen
  def create                                       
    flag = Mugen::Job.create_comment(params[:id], params[:comment])
    redirect_to admin_mygengo_job_path(params[:id])
  end
end