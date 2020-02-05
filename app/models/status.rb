class Status < ApplicationRecord
  has_many :applications
  has_many :interviews
end
