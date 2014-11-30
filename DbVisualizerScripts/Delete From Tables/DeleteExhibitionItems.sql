DELETE FROM
public.t_exhibition_items 
WHERE 
exi_inumkey = ${numkey||(null)||Float}$ and 
exi_ialphakey = ${alpha||(null)||String}$ and 
exi_clientkey = ${client||(null)||String}$ and
exi_ename = ${ename||(null)||String}$ and
exi_exidate_start = ${startdate||(null)||Date}$
;
--tested
