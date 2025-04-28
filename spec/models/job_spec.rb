require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'has a valid factory' do
    expect(create(:job)).to be_valid
  end
end
