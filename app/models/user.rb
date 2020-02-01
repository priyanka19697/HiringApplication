class User < ApplicationRecord
	belongs_to :role

	HiringManager = Role.find(1);
	Interviewer = Role.find(2);

	def self.find_or_create_from_auth_hash(auth)

		where(email: auth.email).first_or_initialize.tap do |user|
			user.name = auth.info.first_name+auth.info.last_name
			user.email = auth.info.email
			user.role = HiringManager
			user.save!
		end
	end
end
