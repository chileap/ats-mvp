require 'rails_helper'

RSpec.describe Application, type: :model do
  it 'has a valid factory' do
    expect(create(:application)).to be_valid
  end
end
