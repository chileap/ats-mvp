require 'rails_helper'

RSpec.describe Application, type: :model do
  it 'has a valid factory' do
    expect(create(:application)).to be_valid
  end

  describe '#status' do
    let(:application) { create(:application) }

    context 'when there are no events' do
      it 'returns "applied"' do
        expect(application.status).to eq('applied')
      end
    end

    context 'when the last event is an interview' do
      it 'returns "interview"' do
        create(:application_event, :interview, application: application)
        expect(application.status).to eq('interview')
      end
    end

    context 'when the last event is a hire' do
      it 'returns "hired"' do
        create(:application_event, :hired, application: application)
        expect(application.status).to eq('hired')
      end
    end

    context 'when the last event is a rejection' do
      it 'returns "rejected"' do
        create(:application_event, :rejected, application: application)
        expect(application.status).to eq('rejected')
      end
    end

    context 'when there are multiple events' do
      it 'returns the status based on the most recent event' do
        create(:application_event, :interview, application: application, created_at: 2.days.ago)
        create(:application_event, :hired, application: application, created_at: 1.day.ago)

        expect(application.status).to eq('hired')
      end
    end

    context 'when the last event is a note' do
      it 'maintains the previous status' do
        # First create an interview event
        create(:application_event, :interview, application: application, created_at: 2.days.ago)
        # Then add a note
        create(:application_event, :note, application: application, created_at: 1.day.ago)

        expect(application.status).to eq('interview')
      end

      it 'returns "applied" if the only event is a note' do
        create(:application_event, :note, application: application)
        expect(application.status).to eq('applied')
      end
    end
  end
end
