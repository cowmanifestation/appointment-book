require "date"

class Schedule

  include Enumerable

  def initialize
  	#file.new?? how do i get it to save a new file for each new object?
    @data = Hash.new { |h,k| h[k] = [] }
  end

  def [](key)
    @data[to_date(key)]
  end

  def each
    @data.each { |o| yield(o) }
  end
  
  #why doesn't this work?
  
 # def save
  #	data = File.new("schedule.rb")
  #	data.puts @data
  #	data.close
#	end
  
  #how do I get it to output a readable date object? do i have to create a to_s method?
  
 # def to_s
  	
	#end

  private

  def to_date(str)
    Date.strptime(str, "%m/%d/%Y")
  end

end

dates = Schedule.new

dates["03/21/1982"] << 'Chenoas Birthday'
dates["03/29/1982"] << 'Awesome day'

puts dates
p dates
#dates.save
