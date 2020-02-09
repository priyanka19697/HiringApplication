class Interview < ApplicationRecord
  belongs_to :application
  belongs_to :user
  belongs_to :status
end


