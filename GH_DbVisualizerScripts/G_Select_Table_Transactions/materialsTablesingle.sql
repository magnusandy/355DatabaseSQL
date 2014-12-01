SELECT
    mat_matname
FROM
    public.v_materials
WHERE
 mat_matname = ${mat||(null)||String}$
 ;