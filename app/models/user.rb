class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_and_belongs_to_many :activities
	has_and_belongs_to_many :editions
	has_many :badge_codes

	def badges
		BadgeCode.where(user_id: id).map { |bc| bc.badge }
	end
end