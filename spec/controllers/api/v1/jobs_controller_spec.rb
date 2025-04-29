require 'rails_helper'

RSpec.describe Api::V1::JobsController, type: :controller do
  describe 'GET #index' do
    let!(:job1) { create(:job, title: 'Software Engineer') }
    let!(:job2) { create(:job, title: 'Product Manager') }

    before do
      # Create activation events for jobs
      create(:job_event, :activated, job: job1)
      create(:job_event, :activated, job: job2)

      # Create applications for job1
      create(:application, job: job1).tap do |app|
        create(:application_event, :hired, application: app)
      end
      create(:application, job: job1).tap do |app|
        create(:application_event, :rejected, application: app)
      end
      create(:application, job: job1).tap do |app|
        create(:application_event, :interview, application: app)
      end

      # Create applications for job2
      create(:application, job: job2).tap do |app|
        create(:application_event, :hired, application: app)
      end
      create(:application, job: job2).tap do |app|
        create(:application_event, :hired, application: app)
      end
      create(:application, job: job2).tap do |app|
        create(:application_event, :interview, application: app)
      end
    end

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns jobs with correct application counts' do
      get :index
      json_response = JSON.parse(response.body)

      job1_response = json_response.find { |job| job['name'] == 'Software Engineer' }
      expect(job1_response).to include(
        'name' => 'Software Engineer',
        'status' => 'activated',
        'hired_count' => 1,
        'rejected_count' => 1,
        'ongoing_count' => 1
      )

      job2_response = json_response.find { |job| job['name'] == 'Product Manager' }
      expect(job2_response).to include(
        'name' => 'Product Manager',
        'status' => 'activated',
        'hired_count' => 2,
        'rejected_count' => 0,
        'ongoing_count' => 1
      )
    end

    it 'returns jobs ordered by title' do
      get :index
      json_response = JSON.parse(response.body)

      expect(json_response.first['name']).to eq('Product Manager')
      expect(json_response.last['name']).to eq('Software Engineer')
    end
  end
end