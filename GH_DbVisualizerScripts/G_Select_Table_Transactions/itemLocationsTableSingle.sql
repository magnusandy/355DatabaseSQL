SELECT
    ilo_inumkey,
    ilo_ialphakey,
    ilo_clientkey_item,
    ilo_locname,
    ilo_clientkey_location,
    ilo_ilodatetime_start,
    ilo_ilodatetime_end
FROM
    public.v_item_locations
    WHERE
    ilo_inumkey = ${numkey||(null)||Float}$ AND
    ilo_ialphakey = ${alpha||(null)||String}$ AND 
    ilo_clientkey_item = ${client||(null)||String}$ AND
    ilo_ilodatetime_start = ${datestart||(null)||Timestamp}$
    ;