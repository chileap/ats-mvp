require 'rails_helper'

RSpec.describe Api::V1::ApplicationsController, type: :controller do
  describe 'GET #index' do
    let!(:activated_job) do
      job = create(:job)
      create(:job_event, :activated, job: job)
      job
    end
    let!(:deactivated_job) do
      job = create(:job)
      create(:job_event, :deactivated, job: job)
      job
    end
    let!(:application1) { create(:application, job: activated_job) }
    let!(:application2) { create(:application, job: activated_job) }
    let!(:deactivated_application) { create(:application, job: deactivated_job) }

    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns only applications for activated jobs' do
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)
    end

    it 'returns applications in the correct format' do
      json_response = JSON.parse(response.body)
      first_application = json_response.first

      expect(first_application).to include(
        'job_name',
        'candidate_name',
        'status',
        'notes_count',
        'last_interview_date'
      )
    end

    it 'orders applications by job title and candidate name' do
      json_response = JSON.parse(response.body)
      job_titles = json_response.map { |app| app['job_name'] }
      expect(job_titles).to eq(job_titles.sort)
    end
  end
end