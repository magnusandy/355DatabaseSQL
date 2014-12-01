DELETE FROM public.t_item_creators WHERE
 cr_inumkey = ${num||(null)||Float}$ and
  cr_ialphakey = ${alpha||(null)||String}$ and
   cr_clientkey = ${clname||(null)||String}$ and
    cr_crname = ${creator||(null)||String}$;
    --tested works
