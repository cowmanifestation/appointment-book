require "rubygems"
require "highline/import"
require "appointment_book"

say "Welcome To Chenoa's Appointment Book"

if agree "Do you want to use the default file? "
  @sch = Schedule.new
else
  @sch = Schedule.new(ask("Which file should I use?"))
end

say "Your schedule is \n#{@sch}"

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
		if @sch["#{date}"].empty?
			puts "No events scheduled."
		else
			puts @sch["#{date}"]
		end
	end
	
end