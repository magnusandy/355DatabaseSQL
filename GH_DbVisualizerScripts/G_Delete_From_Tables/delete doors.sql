DELETE FROM public.t_location_doors WHERE
 lodor_locname_entrance = ${enteranceloc||(null)||String}$
  and lodor_clientkey_entrance = ${cliententerance||(null)||String}$
  and lodor_locname_exit = ${exitloc||(null)||String}$
  and lodor_clientkey_exit = ${clientexit||(null)||String}$;
  --tested works
