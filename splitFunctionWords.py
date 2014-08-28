import string

function_words = "a|about|above|after|again|ago|all|almost|along|already|also|although|always|am|among|an|and|another|any|anybody|anything|anywhere|are|arent|around|as|at|back|else|be|been|before|being|below|beneath|beside|between|beyond|both|each|but|by|can|cant|could|couldnt|did|didnt|do|does|doesnt|doing|done|dont|down|during|either|enough|even|ever|every|everybody|everyone|everything|everywhere|except|far|few|fewer|first|for|from|get|gets|getting|got|had|hadnt|has|hasnt|have|havent|having|he|hed|hell|hence|her|here|hers|herself|hes|him|himself|his|hither|how|however|near|i|id|if|ill|im|in|into|is|ive|isnt|it|its|its|itself|last|less|many|me|may|might|mine|more|most|much|must|mustnt|my|myself|near|nearby|nearly|neither|never|next|no|nobody|none|noone|nothing|nor|not|now|nowhere|of|off|often|on|or|once|one|only|other|others|ought|oughtnt|our|ours|ourselves|out|over|quite|rather|round|second|shall|shant|shed|she|shell|shes|should|shouldnt|since|so|some|somebody|someone|something|sometimes|somewhere|soon|still|such|than|that|thats|the|their|theirs|them|themselves|these|then|thence|there|therefore|they|theyd|theyll|theyre|this|thither|those|though|through|thus|till|to|towards|today|tomorrow|too|under|underneath|unless|until|up|us|very|when|was|wasnt|we|wed|well|were|were|werent|weve|what|whence|where|whereas|which|while|whither|who|whom|whose|why|will|with|within|without|wont|would|wouldnt|yes|yesterday|yet|you|your|youd|youll|youre|yours|yourself|yourselves|youve|theyre|weve"

words_split = str.split(function_words, "|")

cbind = ""

for i in range(0, len(words_split)):
	this_token = words_split[i]
	# print this_token + "_freq[i] <- function_word_freqs[" + str(i+1) + "]"
	cbind += this_token + "_freq, "
print cbind