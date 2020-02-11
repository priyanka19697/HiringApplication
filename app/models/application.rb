class Application < ApplicationRecord
  belongs_to :status
  belongs_to :job
  belongs_to :user
  has_many :interviews
  has_one_attached :resume
end
