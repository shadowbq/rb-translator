#!/usr/bin/env ruby
# replace dictionary.csv input.txt output.txt
incoming_args = ARGV

if incoming_args.length != 3 then
  puts "replace.rb <dictionary> <inputfile> <outputfile>"
  exit 1
end

fdictionary = incoming_args[0]
finput = incoming_args[1]
foutput = incoming_args[2]

content = File.read(finput)

my_dictionary = {}
File.open(fdictionary, 'r') do |file|
  file.each_line do |line|
    line_data = line.split(',')
    my_dictionary[" " + line_data[0].strip + " "] = " " + line_data[1].strip + " "
  end
end

# Search for key with surround blank spaces
my_dictionary.each { |k, v| content.sub!(k, v) }

# Search for key at the beginning of a new line
my_dictionary.each { |k, v| 
  newk = k.lstrip
  g = /^#{newk}/
  content.sub!(g, v.lstrip)
}


f = File.open(foutput, 'w')
f.print content.rstrip
f.close