# extract example seconds from rspec profile log
#
# required:
#   rspec >= 2.10.0
#   Jenkins Plot Plugin
#
# usage:
#   rspec --profile 5 > rspec-console.log # rspec >= 2.13.0
#   rspec --profile > rspec-console.log   # 2.10.0 <= rspec <  2.13.0
#   ruby plot-rspec-slowest-examples.rb rspec-console.log > plot.csv
#
# and more:
#   https://gist.github.com/sue445/5140150

if ARGV.empty?
  puts "usage: ruby plot-rspec-slowest-examples.rb <console-log>"
  exit
end

LOG_FILE =  ARGV[0]

total = {}
example_seconds = []
open(LOG_FILE) do |f|
  f.each_line do |line|
    case line
    when %r{Top (.+) slowest examples \(([0-9.]+) seconds, ([0-9.]+)% of total time\)}
      total[:ratio] = $3
    when %r{Finished in ([0-9.]+) seconds}
      total[:second] = $1
    when %r{([0-9.]+) seconds (.+)}
      example_seconds << $1
    end
  end
end

# header
print "total,"
#print "ratio %,"
example_seconds.count.times do |n|
  print "top #{n+1},"
end
print "\n"

# data row
print "#{total[:second]},"
#print "#{total[:ratio]},"
example_seconds.each do |sec|
  print "#{sec},"
end
print "\n"

