require 'rails_helper'

RSpec.describe Job::Event, type: :model do
  it 'has a valid factory' do
    expect(create(:job_event)).to be_valid
  end
end
