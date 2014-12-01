DELETE FROM public.t_item_materials WHERE 
imat_inumkey = ${numkey||(null)||Float}$ and 
imat_ialphakey = ${alpha||(null)||String}$ and 
imat_clientkey = ${clientkey||(null)||String}$ and
imat_matname = ${matname||(null)||String}$;
--testedworks
