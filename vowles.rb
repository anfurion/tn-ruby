alfabet = ("a".."z").to_a 
vowels = %w[a e i o u y]
hash = {}
alfabet.map.with_index {|x, i| hash[x] = i + 1}

hash.slice(*vowels)
