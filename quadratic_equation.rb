class QuadraticEquation
  def solve(a, b, c)
    d = discriminant(a, b, c)
    if d.positive?
      x1 = solution_one(a, b, d)
      x2 = solution_two(a, b, d)
      "one: #{x1}, two: #{x2}"
    elsif d.zero?
      x = solution_zero(a, b)
      "decision is #{x}"
    else
      'There is no decision'
    end
  end

  def discriminant(a, b, c)
    b**2 - 4 * a * c
  end

  def solution_zero(a, b)
    (-b) / (2 * a)
  end

  def solution_one(a, b, d)
    (-b + Math.sqrt(d)) / (2 * a)
  end

  def solution_two(a, b, d)
    (-b - Math.sqrt(d)) / (2 * a)
  end
end

puts 'Введите значение a'
a = gets.to_f

puts 'Введите значение b'
b = gets.to_f

puts 'Введите значение c'
c = gets.to_f


puts QuadraticEquation.new.solve(a, b, c)
