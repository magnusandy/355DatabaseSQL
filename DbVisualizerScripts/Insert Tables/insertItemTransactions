INSERT
INTO
    public.v_item_transactions
    (
        it_inumkey,
        it_ialphakey,
        it_clientkey,
        it_clname_proprietor,
        it_ittype,
        it_itdatetime_start,
        it_itdatetime_end,
        it_itdatetime_returnby,
        it_itgross,
        it_clname_recipient
    )
    VALUES
    (
        ${numkey||(null)||Float}$,
        ${alphakey||(null)||String}$,
        ${clientkeyITEM||(null)||String}$,
        ${proprietor||(null)||String}$,
        ${transactiontype||(null)||String}$,
        ${itdatestart||(null)||Timestamp|| dt=timestamp }$,
        ${transactiondateend||(null)||Timestamp||nullable ds=7 dt=timestamp }$,
        ${returnbydate||(null)||Timestamp||nullable ds=7 dt=timestamp }$,
        ${transactionGross||(null)||Float}$,
         ${recipient||(null)||String}$

    )
;
--tested, worked