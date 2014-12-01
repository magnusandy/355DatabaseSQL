SELECT
    imat_inumkey,
    imat_ialphakey,
    imat_clientkey,
    imat_matname
FROM
    public.v_item_materials
WHERE
    imat_inumkey = ${numkey||(null)||Float}$ AND 
    imat_ialphakey = ${alpha||(null)||String}$ AND 
    imat_clientkey = ${client||(null)||String}$ AND 
    imat_matname  = ${matname||(null)||String}$
    ;