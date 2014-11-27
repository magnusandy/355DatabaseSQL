INSERT
INTO
    public.v_item_locations
    (
        ilo_inumkey,
        ilo_ialphakey,
        ilo_clientkey_item,
        ilo_locname,
        ilo_clientkey_location,
        ilo_ilodatetime_start,
        ilo_ilodatetime_end
    )
    VALUES
    (    
        ${numkey||(null)||Float}$,
        ${alphakey||(null)||String}$,
        ${clientkeyITEM||(null)||String}$,
        ${locname||(null)||String}$,
        ${clientkeyLOCATION||(null)||String}$,
        ${startdatetime||(null)||Timestamp}$,
        ${enddatetime||(null)||Timestamp||nullable ds=7 dt=TIMESTAMP }$
    )
;
--tested, works