class Application < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_many :interviews
  has_one_attached :resume

  validates :name,presence: true
  validates :email,presence: true
  validates :mobile, presence: true
  validates :experience,presence: true
  validates :resume,presence: true
  validates :job_id,presence: true
  validates :application_status, presence: true
end
