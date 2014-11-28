select 
        exl_ename, exl_exldate_start, exl_exldate_end
FROM
        t_exhibition_locations
WHERE
        exl_clientkey = ${ClientKey||(null)||String}$ AND
        exl_locname = ${Location||(null)||String}$ AND
        exl_exldate_start >= ${startdate||(null)||Date}$ AND
        exl_exldate_end <= ${enddate||(null)||Date}$
;