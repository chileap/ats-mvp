class Candidate < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_many :jobs, through: :applications
end
