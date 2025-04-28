FactoryBot.define do
  factory :application do
    job { create(:job) }
    candidate { create(:candidate) }
  end
end
