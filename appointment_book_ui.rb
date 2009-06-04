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


def create_new
	
	  date = ask("Date? ") { |q| q.validate = %r{\A\d\d?/\d\d?/\d{4}\Z} }
		event = ask("What? ") 
		time = ask("When? ")
		location = ask("Where? ")
		details = ask("Details? ")
		
		@sch.event(date, T(:event, binding))
		
		say "\n\nYour entry: #{date}\n"
		@sch[date].each_with_index {|event, index| say "#{index}: \n#{event}"}
		
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
					index = ask("Which event?   ", Integer) { |q| q.in = 0..@sch[date].length.to_i }
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

					date = ask("Date? ")
					@sch[date].each_with_index {|event, index| puts "#{index}: \n#{event}"}
					index = ask("Which event?   ", Integer) { |q| q.in = 0..@sch[date].length.to_i }
					say "#{@sch[date][index]}"
					
					#select date/time/details etc.
					#Options: Add or replace.
					
					say "Please enter new details:  "
					event = ask("What? ") 
				  time = ask("When? ")
				  location = ask("Where? ")
					details = ask("Details? ")
					
					@sch.event_update(date, index, T(:event, binding))
					
					say "\n\nYour entry: #{date}\n"
					@sch[date].each_with_index {|event, index| say "#{index}: \n#{event}"}
					
					if agree("Edit? ", true)
						edit
					end
					
				end	
				
				main
				
			end
			
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
			date = ask("Date? ")
			@sch[date].each_with_index {|event, index| say "#{index}: \n#{event}"}
		end

=begin		
		menu.choice :today do
			date = Date.today.strptime(str, "%m/%d/%Y")
			@sch[date].each_with_index {|event, index| say "#{index}: \n#{event}"}
		end
=end
		
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