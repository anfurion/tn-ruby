months = {
  'january' => 31,
  'february' => 28,
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
keys = months.keys
puts keys.to_s

months.each_key do |month|
  puts month if months[month] == 30
end
