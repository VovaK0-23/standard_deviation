# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  ruby '>= 2.4.0'
  gem 'tty-prompt'
end

require 'tty-prompt'

prompt = TTY::Prompt.new

data = prompt.ask('Enter data list:') do |q|
  q.required true
  q.convert :ints
end
data = data.sort

def mode(data)
  hash = Hash.new { |h, k| h[k] = [] }
  data.each do |n|
    frequency = data.count(n)
    hash[frequency] << n unless hash[frequency].include?(n)
  end
  hash.max
end

def median(data)
  len = data.length
  (data[(len - 1) / 2] + data[len / 2]) / 2.0
end

def mean(data)
  data.sum.to_f / data.count
end

def range(data)
  data.last - data.first
end

def std_dev(data)
  arr1 = []
  data.each do |i|
    res = (i - mean(data))**2
    arr1 << res
  end
  Math.sqrt(arr1.sum / arr1.count)
end

puts('-----------------------------------------------')
puts("Sorted data: #{data.join(', ')}")
puts('-----------------------------------------------')
puts("Number of elements: #{data.count}")
puts("Sum is: #{data.sum}")
puts("Smallest is: #{data.first}")
puts("Largest is: #{data.last}")
puts('-----------------------------------------------')
puts("Mode is: #{mode(data)[1].join(', ')}, frequency: #{mode(data)[0]}")
puts("Median is: #{median(data)}")
puts("Mean is: #{mean(data)}")
puts("Range is: #{range(data)}")
puts("Standard Deviation is: #{std_dev(data)}")

