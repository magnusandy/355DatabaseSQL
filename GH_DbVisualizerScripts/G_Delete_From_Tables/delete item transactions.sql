DELETE FROM public.t_item_transactions WHERE 
it_inumkey = ${numkey||(null)||Float}$ and
 it_ialphakey = ${alpha||(null)||String}$ and
  it_clientkey = ${clientkey||(null)||String}$ and 
  it_itdatetime_start = ${datestart||(null)||Timestamp}$;
  --tested works
