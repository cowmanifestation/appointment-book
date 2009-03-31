require "rubygems"
require "highline/import"
$terminal = HighLine.new($stdin, $stdout, :auto)

def center_aligned(string)
 width = HighLine::SystemExtensions.terminal_size[0]
 string.center(width)
end

say center_aligned("Hello Chenoa")

say "What is going to happen now? Will this string be wrapped in the right place? We'll find out! Run this program in your command line and see what happens."


#this does not align this string to the center. ??
say center_aligned("\n\nHere's the clincher. Maybe or maybe not.  Anyway I am trying to get my appointments be printed center aligned and also wrapped.  It doesn't seem to work, maybe it's because of the ERB file?  Or maybe it's because they haven't been saved that way?  I don't think so...maybe the output from the ERB file is not really a string or something.  I don't get it.")