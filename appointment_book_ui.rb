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
	  #is it bad to create a variable here with the same name as a method from appointment_book.rb?
	  #it seems to work ok...
		event = ask("What? ") 
		time = ask("When? ")
		location = ask("Where? ")
		details = ask("Details? ")
		
		@sch.event(date, "\tEvent: " + event + "\n\tTime: " + time +
		     "\n\tLocation: " + location + "\n\tDetails: " + details)
		
		puts "\n\nYour entry: #{date}\n"
		@sch[date].each_with_index {|event, index| puts "#{index}: \n#{event}"}
		
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
					@sch[date].each_with_index {|event, index| puts "#{index}: \n#{event}"}
					#@sch[date(index)] = ask "Which event?" q validate (integer) or something like this
				end
				
			end
				
		end
		
		menu.choice :change do
			puts "peregrine falcon"
		end
		
		menu.choice :back do
			main
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
			
			#how do I print this out with the event details indented? like puts "#{index}: #{three spaces} event /n #{five spaces} details...."
			@sch[date].each_with_index {|event, index| puts "#{index}: \n#{event}"}
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


say "\nWelcome To Chenoa's Appointment Book"

@sch = Schedule.new(ARGV[0] || "schedule.store")

say "\nYour schedule: \n\n#{@sch}\n\n"

main


