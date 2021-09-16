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
my_dictionary.each { |k, v| content.gsub!(k, v) }


my_dictionary.each { |k, v| 
  
  # UNSAFE -> content.gsub!(k.strip, v.strip)

  newk = k.lstrip
  # Search for key at the beginning of a new line
  g = /^#{newk}/
  content.gsub!(g, v.lstrip)
  # Search for key prior to (
  g = /\(#{newk}/
  content.gsub!(g, "(" + v.lstrip)
  # Search for key prior to {
  g = /\{#{newk}/
  content.gsub!(g, "{" + v.lstrip)
  # Search for key prior to [
  g = /\[#{newk}/
  content.gsub!(g, "[" + v.lstrip)

  # Look for " key\n"
  newk = k.rstrip
  g = /#{newk}$/
  content.gsub!(g, v.rstrip)
  # Search for key after (
  g = /#{newk}\)/
  content.gsub!(g, v.rstrip + ")")
  # Search for key after {
  g = /#{newk}\}/
  content.gsub!(g, v.rstrip + "}")
  # Search for key after [
  g = /#{newk}\]/
  content.gsub!(g, v.rstrip + "]")


  newk = k.strip
  # Search for (key) 
  g = /\(#{newk}\)/
  content.gsub!(g, "(" + v.strip + ")")
  # Search for {key}
  g = /\{#{newk}\}/
  content.gsub!(g, "{" + v.strip + "}")
  # Search for [key]
  g = /\[#{newk}\]/
  content.gsub!(g, "[" + v.strip + "]")


}


f = File.open(foutput, 'w')
f.print content.rstrip
f.close