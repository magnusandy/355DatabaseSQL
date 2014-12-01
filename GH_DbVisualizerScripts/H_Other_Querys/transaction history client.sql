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
it_clname_proprietor = ${client||(null)||String}$ OR 
it_clname_recipient = ${client||(null)||String}$
ORDER BY 
it_itdatetime_start