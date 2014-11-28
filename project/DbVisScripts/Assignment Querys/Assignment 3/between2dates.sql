select 
        i_iname, exi_exidate_start, exi_exidate_end
FROM
        t_exhibition_items,
        t_items
WHERE
        i_inumkey = exi_inumkey AND
        i_ialphakey = exi_ialphakey AND
        exi_ename = ${name||(null)||String}$ AND
        exi_exidate_start >= ${startdate||(null)||Date}$ AND
        exi_exidate_start <= ${enddate||(null)||Date}$
;