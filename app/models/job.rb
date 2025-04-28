class Job < ApplicationRecord
  has_many :events, class_name: 'Job::Event', dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :candidates, through: :applications

  scope :activated, -> {
    # Find jobs where the most recent event is an activation event
    where(id: Job::Event.select(:job_id)
      .where(type: 'Job::Event::Activated')
      .where('created_at = (
        SELECT MAX(created_at)
        FROM job_events e2
        WHERE e2.job_id = job_events.job_id
      )'))
  }

  def status
    last_event = events.order(created_at: :desc).first
    return 'deactivated' if last_event.nil?

    case last_event.type
    when 'Job::Event::Activated'
      'activated'
    when 'Job::Event::Deactivated'
      'deactivated'
    else
      'deactivated'
    end
  end
end
