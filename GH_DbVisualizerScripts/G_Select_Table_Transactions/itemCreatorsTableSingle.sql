SELECT
    cr_inumkey,
    cr_ialphakey,
    cr_clientkey,
    cr_crname
FROM
    public.v_item_creators
WHERE
    cr_inumkey = ${numkey||(null)||Float}$ AND 
    cr_ialphakey = ${alpha||(null)||String}$ AND 
    cr_clientkey = ${client||(null)||String}$ AND 
    cr_crname  = ${crname||(null)||String}$
    ;