DELETE FROM public.t_item_colors WHERE
 icol_inumkey = ${numkey||(null)||Float}$ and 
 icol_ialphakey = ${alhpa||(null)||String}$ and
 icol_clientkey = ${client||(null)||String}$ and
  icol_icolor = ${color||(null)||String}$
  ;
--tested works