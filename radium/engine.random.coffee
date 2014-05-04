Engine::random =
	number: (min, max, precision) =>
		base_number = Math.random()
		space = Math.abs(max - min)
		rounding_factor = 1 / (precision ? 0.00000001)
		return Math.floor((min + (base_number * space)) * rounding_factor) / rounding_factor
		
	pick: (options...) =>
		return options[Math.floor(Math.random() * options.length)]
		
	string: (length, alphabet) =>
		alphabet ?= "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		return (alphabet[Math.floor(Math.random() * alphabet.length)] for i in [0 .. length - 1]).join("")