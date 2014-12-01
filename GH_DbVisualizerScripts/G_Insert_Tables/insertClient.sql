INSERT
INTO
    public.v_clients
    (
        cl_clname,
        cl_email,
        cl_phonenum,
        cl_buildingnum,
        cl_buildingname,
        cl_streetname,
        cl_city,
        cl_country,
        cl_region,
        cl_postalcode
    )
    VALUES
    (
        ${clientname||(null)||String}$,
        ${email||(null)||String||nullable}$,
        ${phonenumber||(null)||String||nullable}$,
        ${buildingnumber||(null)||String||nullable}$,
        ${buildingname||(null)||String||nullable}$,
        ${streetname||(null)||String||nullable}$,
        ${city||(null)||String||nullable}$,
        ${country||(null)||String||nullable}$,
        ${region||(null)||String||nullable}$,
        ${postalcode||(null)||String||nullable}$
    )
;
--tested, good