def leap?(year)
  ((year % 4).zero? && !(year % 100).zero?) || (year % 400).zero?
end

def days_in_febryary(year)
  leap?(year) ? 29 : 28
end

def calendar(year)
  {
    'january' => 31,
    'febryary' => days_in_febryary(year),
    'march' => 31,
    'april' => 30,
    'may' => 31,
    'june' => 30,
    'july' => 31,
    'august' => 31,
    'september' => 30,
    'octoberr' => 31,
    'november' => 30,
    'december' => 31
  }
end

def daynumber(day, month, year)
  calendar = calendar(year)
  days_previus_months = calendar.values.first(month - 1).sum
  days_previus_months + day
end

puts 'Введите день'
day = gets.to_i

puts 'Введите месяц'
month = gets.to_i

puts 'Введите год'
year = gets.to_i

num =  daynumber(day, month, year)
puts "Номер дня в году #{num}"
