array = [0, 1]
loop do
  pp array.last 2
  summ = array.last(2).sum
  break if summ > 100

  array << summ
end
puts array.inspect
