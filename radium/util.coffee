util = 
	stripRight: (string, character) ->
		string.replace(new RegExp(character + "*$", "g"), "")
	unpackElement: (element) ->
		console.log(element)
		if element instanceof jQuery then element[0] else element