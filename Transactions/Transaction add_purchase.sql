select add_purchase(
	${numkey||null||Float}$, 
	${alphakey||null||String}$, 
	${buyer||null||String}$, 
	${exstartdate||null||Date}$, 
	${cost||(null)||Float}$
);