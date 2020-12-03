def ideal_weight(name, height)
  ideal = (height - 110) * 1.15
  if ideal.positive?
    "#{name} #{ideal}"
  else
    "#{name}, already ideal"
  end
end
