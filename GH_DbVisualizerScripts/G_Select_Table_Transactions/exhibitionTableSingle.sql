SELECT
    ex_ename,
    ex_showdate_start,
    ex_showdate_end,
    ex_edescription
FROM
    public.v_exhibitions
WHERE 
ex_ename = ${ename||(null)||String}$ AND
ex_showdate_start = ${showdate||(null)||Date}$ 
;