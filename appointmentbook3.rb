require "date"

print "Hello.  Please enter a date: "
@date = gets
@date.strptime(@date, "%m/%d/%y")