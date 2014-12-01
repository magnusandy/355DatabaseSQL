DELETE FROM public.t_locations WHERE
 loc_locname = ${loc||(null)||String}$ and
  loc_clientkey = ${clientkey||(null)||String}$;
--tested works