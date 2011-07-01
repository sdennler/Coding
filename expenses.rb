#!/usr/bin/ruby

# expenses.txt looks like
# creation	date	amount	comment
# 2011-06-22 23:23:06	22/06/11	200.00	Food

class Hash
  def inject(n)
     each { |value| n = yield(n, value) }
     n
  end
  def sum
    inject(0) { |n, value| n + value }
  end
end

data = []
File.open('expenses.txt') do |file|
	throw 'not a expense file' unless file.gets =~ /creation.date.amount.comment/  
	file.each {|l| data << l.split(/\t|\n/)}
end

data.each {|l| l[1].gsub!(/((..).(..).(..))/, '20\4-\3-\2')}
data.sort! {|x,y| x[1] <=> y[1]}
expenses_per_day = Hash.new(Array.new(0));
data.each {|l|
 expenses_per_day[l[1]][0] += l[2].to_i
}

putsl = proc {|l| puts l.inspect}
data.each &putsl
expenses_per_day.each &putsl
