class User < ApplicationRecord
	belongs_to :role
	has_many :interviews
	has_many :applications


	HiringManager = Role.find(1);
	Interviewer = Role.find(2);

	def self.find_or_create_from_auth_hash(auth)
		where(email: auth.info.email).first_or_initialize.tap do |user|
			if auth.info.email == "priyanka@beautifulcode.in" || auth.info.email == "sushant@beautifulcode.in"
				user.role = HiringManager
			else
				user.role = Interviewer
      end
			user.name = auth.info.name
			user.email = auth.info.email
			user.save!
		end
	end

  def beautifulcode_mail
    return unless email
    return if ['beautifulcode.in', 'beautifulcode.co'].include?(email.split('@')[1])

    errors.add(:email, 'must be a beautifulcode email')
  end
end
