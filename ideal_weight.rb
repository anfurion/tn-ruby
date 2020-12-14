def ideal_weight(name, height)
  ideal = (height - 110) * 1.15
  if ideal.positive?
    "#{name} #{ideal}"
  else
    "#{name}, already ideal"
  end
end

puts 'Введите имя'
name = gets.to_s

puts 'Введите рост'
height = gets.to_f

puts ideal_weight(name, height)
