 SELECT
    exi_inumkey,
    exi_ialphakey,
    exi_clientkey,
    exi_ename,
    exi_showdate_start,
    exi_exidate_end
FROM
    public.v_exhibition_items
Where
exi_inumkey = ${inumkey||(null)||Float}$ AND 
exi_ialphakey = ${alpha||(null)||String}$ AND 
exi_clientkey = ${client||(null)||String}$ AND 
exi_ename = ${ename||(null)||String}$ AND 
exi_exidate_start = ${itemDateStart||(null)||Timestamp}$
; 
