INSERT
INTO
    public.v_location_doors
        (
            lodor_locname_entrance,
            lodor_clientkey_entrance,
            lodor_locname_exit, 
            lodor_clientkey_exit
        )
    VALUES 
        (
            ${entrance||(null)||String}$, 
            ${clientkeyEnterance||(null)||String}$, 
            ${exit||(null)||String}$, 
            ${clientkeyExit||(null)||String}$
        )
;
--tested, works