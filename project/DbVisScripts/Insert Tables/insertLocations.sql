INSERT 
INTO 
    public.v_locations 
        (
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
        )
    VALUES 
        (
                ${locationName||||String}$,  
                ${clientKey||||String}$, 
                ${locationType||||String}$, 
                ${numitemsMin||(null)||Integer||nullable dt=smallint}$,
                ${numitemsMax||(null)||Integer||nullable dt=smallint}$,
                ${height||(null)||Float||nullable dt=real}$,
                ${length||(null)||Float||nullable dt=real}$,
                ${width||(null)||Float||nullable dt=real}$,
                ${creationDate||(null)||Date||nullable dt=date}$,
                ${dateStart||(null)||Date||nullable dt=date}$,
                ${dateEnd||(null)||Date||nullable dt=date}$,
                ${insurance||(null)||Float||nullable dt=numeric}$
        )
;

--tested, works
