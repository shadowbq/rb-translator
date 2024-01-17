# rb-translator

*Note: This is not tokenization, and it is not generally safe.*

`replace.rb <dictionary> <inputfile> <outputfile>`

Quick spike tool to replace a dictionary of terms in text.

`./replace.rb test/dic.csv test/longtext.txt test/shorttext.txt`

Replaces instances surrounded by spaces, at the beginning of new lines, and prior to `(,[,{` characters, and at the end of lines.
