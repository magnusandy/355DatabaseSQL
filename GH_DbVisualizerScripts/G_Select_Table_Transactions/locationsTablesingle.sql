SELECT
    loc_locname,
    loc_clientkey,
    loc_loctype,
    loc_numitems_min,
    loc_numitems_max,
    loc_locdimensionmetres_height,
    loc_locdimensionmetres_length,
    loc_locdimensionmetres_width,
    loc_loccreationdate,
    loc_elocdate_start,
    loc_elocdate_end,
    loc_iinsurance_total
FROM
    public.v_locations
    WHERE
        loc_locname = ${enteranceloc||(null)||String}$ AND 
    loc_clientkey = ${clkeyenter||(null)||String}$ 
    ; 