def triangle_square(a, h)
  0.5 * a * h
end

puts 'Ввести основание треугольника'
a = gets.to_f

puts 'Ввести высоту треугольника'
h = gets.to_f
puts triangle_square(a, h)
