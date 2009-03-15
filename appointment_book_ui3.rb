require "rubygems"
require "highline/import"
require "appointment_book"

def main
	
	choose do |menu|
		menu.index = :letter
		
		menu.choice :new_entry do
			create_new
		end
		
		menu.choice :view do
			view
		end
		
		menu.choice :edit do
			edit
		end
		
		menu.choice :quit do
			exit
		end
		
	end
	
end


def create_new
	
	date = ask("Date? ")
		event = ask("What? ")
		time = ask("When? ")
		location = ask("Where? ")
		details = ask("Details? ")
		
		@sch.event(date, "Event: " + event + "\nTime: " + time +
		     "\nLocation: " + location + "\nDetails: " + details)
		     
		puts "\nYour entry:\n#{@sch["#{date}"]}"
		
		if agree("Edit? ", true)
			edit
		end
		
	main
end

def edit
	choose do |menu|
		
		#this doesn't work
		menu.choice :delete do
			date = ask("Date? ")
			@sch.delete["#{date}"]
		end
		menu.choice :alter do
			puts "peregrine falcon"
		end
	end
	puts "donkey"
	main
end

def view
	choose do |menu|
		menu.prompt = "Please select: "
		
		menu.choice :all_appointments do
			puts #{@sch}
		end
		
		menu.choice :single_date do
			date = ask("Date? ")
			puts "#{@sch["#{date}"]}"
		end
		
	end
	
	choose do |menu|
		
		menu.choice :edit do
			edit
		end
		
		menu.choice :back do
			main
		end
		
	end
	
end


say "Welcome To Chenoa's Appointment Book"

if agree "Do you want to use the default file? "
  @sch = Schedule.new
else
  @sch = Schedule.new(ask("Which file should I use?"))
end

say "Your schedule is #{@sch}"

main


