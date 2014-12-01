INSERT
INTO
    public.v_exhibitions
    (
        ex_ename,
        ex_showdate_start,
        ex_showdate_end,
        ex_edescription
    )
    VALUES
    (
        ${ename||(null)||String}$,
        ${showdateStart||(null)||Date}$,
        ${showDateEnd||(null)||Date}$,
        ${description||(null)||String}$
    )
;
--tested, works