FactoryBot.define do
  factory :job_event, class: 'Job::Event' do
    job { create(:job) }

    trait :activated do
      type { 'Job::Event::Activated' }
    end

    trait :deactivated do
      type { 'Job::Event::Deactivated' }
    end
  end
end
