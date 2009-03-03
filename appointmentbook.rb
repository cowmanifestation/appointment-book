class AppointmentBook
	
	require "date"
	
	def initialize
		@appointment_book = Hash.new("No appointments.")
	end
	
	