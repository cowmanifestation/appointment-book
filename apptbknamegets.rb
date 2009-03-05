require "date"
require "pstore"

class Schedule
	
  include Enumerable

  def initialize
  	print "Welcome to Chenoa's scheduling program.  Please enter a name for your file: "
		@name = gets.chomp
		file = "#{@name}.store"
    @store = PStore.new(file)
  end

  def [](date)
    @store.transaction do 
      events_for(date)
    end
  end

  def event(date, text)
    @store.transaction do
      events_for(date) << text
    end
  end
    
  def clear(date)
  	@store.transaction do
  		events_for(date).clear
		end
	end
	
	#NOTE:
	#when writing function calls, consider the kinds of objects you are creating and how you can use them.
	
	#remove a single event
	def remove(date, index)
		@store.transaction do
			events_for(date).delete_at(index)
		end
	end

  def each
    @store.transaction do
      @store.roots.each { |date| yield([date, @store[date]]) }
    end
  end

  def to_s
    map do |(date, appointments)|
      date.strftime("%m/%d/%Y") + " (#{appointments.length})"
    end.join("\n")
  end

  private

  def events_for(date)
    @store[to_date(date)] ||= []
  end

  def to_date(str)
    Date.strptime(str, "%m/%d/%Y")
  end

end
