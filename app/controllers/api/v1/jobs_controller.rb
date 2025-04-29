module Api
  module V1
    class JobsController < BaseController
      def index
        jobs = Job.includes(:applications).order(:title)

        render json: jobs.map { |job|
          applications = job.applications
          {
            name: job.title,
            status: job.status,
            hired_count: applications.count { |app| app.status == 'hired' },
            rejected_count: applications.count { |app| app.status == 'rejected' },
            ongoing_count: applications.count { |app| !['hired', 'rejected'].include?(app.status) }
          }
        }
      end
    end
  end
end