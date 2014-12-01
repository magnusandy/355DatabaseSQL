DELETE FROM public.t_exhibitions WHERE ex_ename = ${ename||(null)||String}$ and ex_showdate_start = ${shartdate||(null)||Date}$;
--tested works
