select insertItemIntoInternalExhibition(
  ${numkey||null||Float}$, 
  ${alphakey||null||String}$, 
  ${exhibitionname||null||String}$, 
  ${exstartdate||null||Date}$, 
  ${iteminexhibitionstart||null||Date}$, 
  ${iteminexhibitionend||null||Date}$,
  ${location||null||String}$, ${clientlocationkey||null||String}$
);
