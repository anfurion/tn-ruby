class Pifagor
  def check(a, b, c)
    return 'equilateral' if equilateral?(a, b, c)
    return 'isosceles' if isosceles?(a, b, c)
    return 'right' if right_triangle?(a, b, c)

    'none'
  end

  def right_triangle?(a, b, c)
    side1, side2, hypotenuse = [a, b, c].sort

    (side1**2 + side2**2) == hypotenuse**2
  end

  def equilateral?(a, b, c)
    a == b && a == c && c == b
  end

  def isosceles?(a, b, c)
    a == b || a == c || c == b
  end
end

puts 'Введите первую сторону треугольника'
a = gets.to_f

puts 'Введите вторую сторону треугольника'
b = gets.to_f

puts 'Введите третью сторону треугольника'
c = gets.to_f

puts Pifagor.new.check(a, b, c)
