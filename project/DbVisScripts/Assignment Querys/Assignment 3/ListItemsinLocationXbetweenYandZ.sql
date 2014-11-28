-- List the items in location X between dates Y and Z

select 
        ilo_inumkey, ilo_ialphakey, ilo_clientkey_item, ilo_ilodatetime_start, ilo_ilodatetime_end
FROM
        t_item_locations
WHERE
        ilo_clientkey_item = ${ClientKey||(null)||String}$ AND
        ilo_locname = ${Location||(null)||String}$ AND
        ilo_ilodatetime_start >= ${startdate||(null)||Date}$ AND
        ilo_ilodatetime_end <= ${enddate||(null)||Date}$
;