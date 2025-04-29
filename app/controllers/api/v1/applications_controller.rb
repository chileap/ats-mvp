module Api
  module V1
    class ApplicationsController < BaseController
      def index
        applications = Application.joins(:job)
                                .where(jobs: { id: Job.activated })
                                .includes(:job, :candidate)
                                .order('jobs.title ASC, candidates.name ASC')

        render json: applications.map { |app|
          {
            job_name: app.job.title,
            candidate_name: app.candidate.name,
            status: app.status,
            notes_count: app.notes_count,
            last_interview_date: app.last_interview_date
          }
        }
      end
    end
  end
end