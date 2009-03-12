require "rubygems"
require "highline/import"
require "appointment_book"

say "Welcome to Chenoa's Appointment Book."

@sch = Schedule.new

choose do |menu|
	menu.index = :letter
	menu.index_suffix = "."
	
	menu.prompt = "Please select: "
	
	menu.choice :new_entry do
		say "Please enter a date: "
		date = gets.chomp
		say "Please enter details: "
		details = gets.chomp
		@sch.event(date, details)
	end
	
	menu.choice :existing_date do
		say "Your existing appointments are: \n#{@sch}
		\nPlease choose one to see the details: "
		date = gets.chomp
		puts @sch["#{date}"]
	end
	
end