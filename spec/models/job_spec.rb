require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'has a valid factory' do
    expect(create(:job)).to be_valid
  end

  describe '.activated' do
    let!(:job1) { create(:job) }
    let!(:job2) { create(:job) }
    let!(:job3) { create(:job) }

    before do
      create(:job_event, :activated, job: job1, created_at: 2.days.ago)
      create(:job_event, :deactivated, job: job1, created_at: 1.day.ago)
      create(:job_event, :activated, job: job2, created_at: 1.day.ago)
      create(:job_event, :activated, job: job3, created_at: 3.days.ago)
      create(:job_event, :deactivated, job: job3, created_at: 2.days.ago)
    end

    it 'returns only jobs with the most recent event being an activation' do
      expect(Job.activated).to contain_exactly(job2)
    end
  end

  describe '#status' do
    let(:job) { create(:job) }

    context 'when there are no events' do
      it 'returns deactivated' do
        expect(job.status).to eq('deactivated')
      end
    end

    context 'when there are multiple events' do
      context 'with the last event being activated' do
        before do
          create(:job_event, :deactivated, job: job, created_at: 3.days.ago)
          create(:job_event, :activated, job: job, created_at: 2.days.ago)
          create(:job_event, :deactivated, job: job, created_at: 1.day.ago)
          create(:job_event, :activated, job: job)
        end

        it 'returns activated' do
          expect(job.status).to eq('activated')
        end
      end

      context 'with the last event being deactivated' do
        before do
          create(:job_event, :activated, job: job, created_at: 3.days.ago)
          create(:job_event, :deactivated, job: job, created_at: 2.days.ago)
          create(:job_event, :activated, job: job, created_at: 1.day.ago)
          create(:job_event, :deactivated, job: job)
        end

        it 'returns deactivated' do
          expect(job.status).to eq('deactivated')
        end
      end

      context 'with multiple events of the same type' do
        before do
          create(:job_event, :activated, job: job, created_at: 3.days.ago)
          create(:job_event, :activated, job: job, created_at: 2.days.ago)
          create(:job_event, :activated, job: job, created_at: 1.day.ago)
        end

        it 'returns activated when all events are activations' do
          expect(job.status).to eq('activated')
        end
      end
    end

    context 'when events are created in quick succession' do
      let(:now) { Time.current }

      before do
        create(:job_event, :activated, job: job, created_at: now)
        create(:job_event, :deactivated, job: job, created_at: now + 1.second)
      end

      it 'returns the status of the most recent event' do
        expect(job.status).to eq('deactivated')
      end
    end
  end
end
