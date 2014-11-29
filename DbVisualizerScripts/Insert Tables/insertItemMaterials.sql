INSERT 
INTO 
    public.v_item_materials
        (
            imat_inumkey,
            imat_ialphakey,
            imat_clientkey,
            imat_matname
        )
    VALUES
        (
            ${numkey||(null)||Float}$,
            ${alphakey||(null)||String}$, 
            ${clientkey||(null)||String}$,
            ${matname||(null)||String}$
        )
;
--tested, works
