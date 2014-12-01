SELECT
    icol_inumkey,
    icol_ialphakey,
    icol_clientkey,
    icol_icolor
FROM
    public.v_item_colors
WHERE
    icol_inumkey = ${numkey||(null)||Float}$ AND 
    icol_ialphakey = ${alpha||(null)||String}$ AND 
    icol_clientkey = ${client||(null)||String}$ AND 
    icol_icolor  = ${color||(null)||String}$
    ;
    --what?