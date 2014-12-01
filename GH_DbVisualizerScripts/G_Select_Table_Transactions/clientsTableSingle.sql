SELECT
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
FROM
    public.v_clients
WHERE 
cl_clname = ${clname||(null)||String}$
;