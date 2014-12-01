SELECT
    i_inumkey,
    i_ialphakey,
    i_clientkey,
    i_iname,
    i_iorigin,
    i_iformat,
    i_isubformat,
    i_ischool,
    i_isubject,
    i_iinsurance,
    i_iacquisitiondate,
    i_icreationyear,
    i_idescription,
    i_itsvector
FROM
    public.v_items
    WHERE
    i_inumkey = ${numkey||(null)||Float}$ AND 
    i_ialphakey = ${alpha||(null)||String}$ AND 
    i_clientkey = ${client||(null)||String}$ 
    ;