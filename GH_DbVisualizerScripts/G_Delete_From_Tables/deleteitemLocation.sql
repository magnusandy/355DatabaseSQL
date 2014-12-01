DELETE FROM public.t_item_locations WHERE 
ilo_inumkey = ${numkey||(null)||Float}$ and 
ilo_ialphakey = ${alpha||(null)||String}$ and 
ilo_clientkey_item = ${clientkey_item||(null)||String}$ and 
ilo_ilodatetime_start = ${datetimestart||(null)||Timestamp}$;
--tested works