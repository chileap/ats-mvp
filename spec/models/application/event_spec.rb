require 'rails_helper'

RSpec.describe Application::Event, type: :model do
  it 'has a valid factory' do
    expect(create(:application_event)).to be_valid
  end
end
