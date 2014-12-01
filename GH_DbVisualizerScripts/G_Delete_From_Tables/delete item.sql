DELETE FROM public.t_items WHERE
 i_inumkey =${numkey||(null)||Float}$
 and i_ialphakey = ${alpha||(null)||String}$ and
  i_clientkey = ${clientkey||(null)||String}$;
  --tested works
