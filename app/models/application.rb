class Application < ApplicationRecord
  belongs_to :job
  belongs_to :candidate

  has_many :events, class_name: 'Application::Event', dependent: :destroy

  def status
    last_event = events.where.not(type: 'Application::Event::Note').order(created_at: :desc).first
    return 'applied' if last_event.nil?

    case last_event.type
    when 'Application::Event::Interview'
      'interview'
    when 'Application::Event::Hired'
      'hired'
    when 'Application::Event::Rejected'
      'rejected'
    else
      'applied'
    end
  end

  def last_interview_date
    events.where(type: 'Application::Event::Interview')
          .order(interview_date: :desc)
          .first&.interview_date
  end

  def notes_count
    events.where(type: 'Application::Event::Note').count
  end
end
