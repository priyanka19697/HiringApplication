class Application < ApplicationRecord
  belongs_to :status
  belongs_to :job
  has_many :interviews
end
