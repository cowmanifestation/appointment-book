require "rubygems"
require "highline/import"
$terminal = HighLine.new($stdin, $stdout, :auto)
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

def ask_date
	date = ask("Date? (m(m)/d(d)/yyyy)")
	if date =~ /\A[0-1][0-9]\/[0-3][0-9]\/\d{4}\Z/
	 date
	else
		say "Something's wrong."
		ask_date
	end
end

def display_date(date)
	@sch[date].each_with_index {|event, index| say "#{index}: \n#{event}"}
end

def create_new
	
	  date = ask_date
		event = ask("What? ") 
		time = ask("When? ")
		location = ask("Where? ")
		details = ask("Details? ")
		
		@sch.event(date, T(:event, binding))
		
		say "\n\nYour entry: #{date}\n"
		display_date(date)
		
		if agree("Edit? ", true)
			edit(date)
		end
		
	main
end


def edit(date = nil)
  unless date
    date = ask_date
  end
	choose do |menu|	
	
		menu.choice :delete do
			date
			choose do |menu|
				
				menu.choice :all do
					@sch.clear_date(date)
				end
				
				menu.choice :single_event do
					display_date(date)
					index = ask("Which event?   ", Integer) { |q| 
					q.in = 0..@sch[date].length.to_i }
					@sch.remove(date, index)
				end
				
				menu.choice :back do
					edit
				end
				
			end
				
		end
	
		menu.choice :change do
			
			choose do |menu|
				
				menu.choice :replace do

					date
					display_date(date)
					index = ask("Which event?   ", Integer) { |q| 
					q.in = 0..@sch[date].length.to_i - 1 }
					#don't need to_i
					say "#{@sch[date][index]}"
					
					#select date/time/details etc.
					#Options: Add or replace.
					
					say "Please enter new details:\n "
					event = ask("What? ") 
				  time = ask("When? ")
				  location = ask("Where? ")
					details = ask("Details? ")
					
					@sch.event_update(date, index, T(:event, binding))
					
					say "\n\nYour entry: #{date}\n"
					display_date(date)
					
					if agree("Edit? ", true)
						edit(date)
					end
					
				end
				
			end
			
			main
			
		end
		
		menu.choice :back do
			main
		end
		
	end
	main
end


def view
	choose do |menu|
		menu.prompt = "Please select: "
		
		menu.choice :all_appointments do
			puts @sch
		end
		
		menu.choice :single_date do
			date = ask_date
			display_date(date)
		end
	
		menu.choice :today do
			d = Time.now
			date = d.strftime("%m/%d/%Y")
			display_date(date)
		end
		
		menu.choice :back do
			main
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

def T(name, bound_to)
  file = File.read(File.dirname(__FILE__) + "/templates/#{name}.erb")
	ERB.new(file).result(bound_to)
end


say "\nWelcome To Chenoa's Appointment Book"

@sch = Schedule.new(ARGV[0] || "schedule.store")

say "\nYour schedule: \n\n#{@sch}\n\n"

main