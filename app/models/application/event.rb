class Application::Event < ApplicationRecord
  belongs_to :application
end

class Application::Event::Interview < Application::Event
  validates :interview_date, presence: true
end

class Application::Event::Hired < Application::Event
  validates :hired_at, presence: true
end

class Application::Event::Rejected < Application::Event; end

class Application::Event::Note < Application::Event
  validates :content, presence: true
end
