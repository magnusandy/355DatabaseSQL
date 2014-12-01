SELECT
    exl_ename,
    exl_showdate_start,
    exl_locname,
    exl_clientkey,
    exl_exldate_start,
    exl_exldate_end,
    exl_security
FROM
    public.v_exhibition_locations
WHERE
exl_ename = ${ename||(null)||String}$ AND 
exl_locname = ${locanme||(null)||String}$ AND 
exl_clientkey = ${clientkeyLoc||(null)||String}$ AND 
exl_exldate_start = ${exldatestart||(null)||Date}$ 
; 
