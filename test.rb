#!/usr/bin/env ruby
require 'FileUtils'

system("replace.rb", "test/dic.csv", "test/longtext.txt", "test/shorttext.txt")

puts FileUtils.compare_file("test/shorttext.txt", "test/proof.txt")