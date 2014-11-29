-- List the Exhibitions some item X is in between dates Y and Z

select 
        exi_ename, exi_showdate_start, exi_exidate_start, exi_exidate_end
FROM
        t_exhibition_items
WHERE
        exi_inumkey = ${itemNum||(null)||Float}$ AND
        exi_ialphakey = ${itemAlpha||(null)||String}$ AND
        exi_clientkey = ${ClientKey||(null)||String}$ AND
        exi_exidate_start >= ${startdate||(null)||Date}$ AND
        exi_exidate_end <= ${enddate||(null)||Date}$
;