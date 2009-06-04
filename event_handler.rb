def event(name, date, &block)
  Event.create(name, date).instance_eval(&block)
end

class Event 
  def self.create(name, date)
    @events ||= {}
    @events[[name,date]] = new(name, date)
  end
  
  #to save a new event from irb, make a function to dump them in a yaml file

  def initialize(name, date)
    @name = name
    @date = date
  end

  def self.all
    (@events ||= {}).values
  end

  def self.on_date(date)
    all.select { |e| e.date == date }
  end
  
  def self.class_def(name, &block)
  	(class << self; self; end).send(:define_method, name, &block)
	end
  
  [:name, :date, :desc, :place, :time].each do |attrib|
  	attr_accessor attrib
  	
  	class_def "#{attrib}s" do
  		all.map { |e| e.send(attrib) }
		end
		
		
		class_def "find_by_#{attrib}" do |value|
			all.select  { |e| e.send(attrib) =~ value }
		end
		
	end

  def description(desc=nil)
    if desc
      @desc = desc
    else
      @desc
    end
  end

  def place(where=nil)
    if where
      @where = where
    else
      @where
    end
  end
  
  def time(time=nil)
  	if time
  		@time = time
		else
			@time
		end
	end

  def to_s
    "\nWhat: #{@name}\nWhen: #{@date} at #{@time}\nWhere: #{@where}\nDetails: #{@desc}\n\n"
  end

end
