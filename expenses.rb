#!/usr/bin/ruby

data = []
file = File.new('expenses.txt')
throw Exception.new 'not a expense file' unless file.gets =~ /creation.date.amount.comment/  
file.each {|l| data << l.split(/\t|\n/)}

data.each {|l| l[1].gsub!(/((..).(..).(..))/, '20\4-\3-\2')}
data.sort! {|x,y| x[1] <=> y[1]}
expenses_per_day = Hash.new(Array.new(0));
data.each {|l|
 expenses_per_day[l[1]][0] += l[2].to_i
}

putsl = proc {|l| puts l.inspect}
data.each &putsl
expenses_per_day.each &putsl
