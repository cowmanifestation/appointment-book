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
	
	  date = ask("Date? ") { |q| q.validate = %r{\A\d\d?/\d\d?/\d{4}\Z} }
		event = ask("What? ") 
		time = ask("When? ")
		location = ask("Where? ")
		details = ask("Details? ")
		
		@sch.event(date, "Event: " + event + "\nTime: " + time +
		     "\nLocation: " + location + "\nDetails: " + details)
		
		puts "\nYour entry: #{@sch[date]}"
		
		if agree("Edit? ", true)
			edit
		end
		
	main
end

def edit
	choose do |menu|	
	
		menu.choice :delete do
			date = ask("Date? ")
			choose do |menu|
				
				menu.choice :all do
					@sch.clear_date(date)
				end
				
				menu.choice :single_event do
					puts "flying monkeys."
				end
				
			end
				
		end
		
		menu.choice :change do
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
			puts @sch
		end
		
		menu.choice :single_date do
			date = ask("Date? ")
			puts @sch[date]
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

@sch = Schedule.new(ARGV[0] || "schedule.store")

say "Your schedule is #{@sch}"

main


