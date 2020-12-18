array = [0, 1]
loop do
  summ = array.last(2).sum
  break if summ > 100

  array << summ
end
puts array.inspect
