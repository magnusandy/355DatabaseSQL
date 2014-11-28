Select
it_inumkey, 
it_ialphakey, 
it_clientkey, 
it_clname_proprietor, 
it_ittype, 
it_itdatetime_start, 
it_itdatetime_end, 
it_itdatetime_returnby, 
it_itgross, 
it_clname_recipient
from
v_item_transactions 
where 
it_inumkey = ${numkey||(null)||Float}$ AND
it_ialphakey = ${alphakey||(null)||String}$ AND 
it_clientkey = ${clientkey||(null)||String}$
ORDER BY 
it_itdatetime_start