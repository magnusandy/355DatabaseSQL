DELETE FROM public.t_exhibition_locations WHERE
 exl_ename = ${ename||(null)||String}$ and
  exl_locname = ${locname||(null)||String}$ and
   exl_clientkey = ${clname||(null)||String}$ and 
   exl_exldate_start = ${datestart||(null)||Date}$
   ;
-- NOT tested, should work