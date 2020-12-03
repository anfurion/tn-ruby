class Pifagor
  def check(a, b, c)
    return 'equilateral' if equilateral?(a, b, c)
    return 'isosceles' if isosceles?(a, b, c)
    return 'right' if right_triangle?(a, b, c)

    puts 'none'
  end

  def right_triangle?(a, b, c)
    hypotenuse = [a, b, c].max
    sides = [a, b, c] - [hypotenuse]
    side1 = sides.first
    side2 = sides.last
    (side1**2 + side2**2) == hypotenuse**2
  end

  def equilateral?(a, b, c)
    a == b && a == c && c == b
  end

  def isosceles?(a, b, c)
    a == b || a == c || c == b
  end
end
