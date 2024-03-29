class Todo < ActiveRecord::Base

	after_initialize :init

	scope :unfinished, where(:done => false)
	scope :finished, where(:done => true)

	validates :body, :presence => true
	validate :deadline_cannot_be_in_the_past

	private
	
	def deadline_cannot_be_in_the_past
		if !deadline.blank? and deadline < Date.today
			errors.add(:deadline, "can't be in the past")
		end
	end

	def init
		self.done ||= false
	end
end
