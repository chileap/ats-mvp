FactoryBot.define do
  factory :application_event, class: 'Application::Event' do
    application { create(:application) }
    type { 'Application::Event::Interview' }
    interview_date { Faker::Time.between(from: 1.day.ago, to: 1.day.from_now) }
    content { Faker::Lorem.paragraph }

    trait :interview do
      type { 'Application::Event::Interview' }
      interview_date { Faker::Time.between(from: 1.day.ago, to: 1.day.from_now) }
      content { Faker::Lorem.paragraph }
    end

    trait :hired do
      type { 'Application::Event::Hired' }
      hired_at { Faker::Time.between(from: 1.day.ago, to: 1.day.from_now) }
    end

    trait :rejected do
      type { 'Application::Event::Rejected' }
      rejected_at { Faker::Time.between(from: 1.day.ago, to: 1.day.from_now) }
    end

    trait :note do
      type { 'Application::Event::Note' }
      content { Faker::Lorem.paragraph }
    end
  end
end
