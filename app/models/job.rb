class Job < ApplicationRecord
  has_many :events, class_name: 'Job::Event', dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :candidates, through: :applications
end
