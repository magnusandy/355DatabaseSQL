SELECT
    lodor_locname_entrance,
    lodor_clientkey_entrance,
    lodor_locname_exit,
    lodor_clientkey_exit
FROM
    public.v_location_doors
    where
    lodor_locname_entrance = ${enteranceloc||(null)||String}$ AND 
    lodor_clientkey_entrance = ${clkeyenter||(null)||String}$ AND 
    lodor_locname_exit = ${exit||(null)||String}$ AND 
    lodor_clientkey_exit = ${clexit||(null)||String}$  
    ;