class Application < ApplicationRecord
  belongs_to :job
  belongs_to :candidate

  has_many :events, class_name: 'Application::Event', dependent: :destroy
end
