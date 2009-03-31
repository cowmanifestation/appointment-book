def event(name, date, &block)
  Event.create(name, date).instance_eval(&block)
end

class Event 
  def self.create(name, date)
    @events ||= {}
    @events[[name,date]] = new(name, date)
  end

  def initialize(name, date)
    @name = name
    @date = date
  end

  attr_accessor :name, :date, :where, :desc

  def self.all
    (@events ||= {}).values
  end

  def self.on_date(date)
    all.select { |e| e.date == date }
  end

  def description(desc=nil)
    if desc
      @desc = desc
    else
      @desc
    end
  end

  def where(where=nil)
    if where
      @where = where
    else
      @where
    end
  end

  def to_s
    "What: #{@name}\nWhen: #{@date}\nWhere: #{@where}\nDetails: #{@desc}"
  end

end
