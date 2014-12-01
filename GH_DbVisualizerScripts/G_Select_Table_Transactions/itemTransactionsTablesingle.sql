SELECT
        it_inumkey, 
        it_ialphakey, 
        it_clientkey, 
        it_clname_proprietor, 
        it_clname_recipient,
        it_ittype, 
        it_itdatetime_start, 
        it_itdatetime_end, 
        it_itdatetime_returnby, 
        it_itgross
        
         FROM
  public.v_item_transactions
  WHERE
    it_inumkey = ${numkey||(null)||Float}$ AND 
    it_ialphakey = ${alpha||(null)||String}$ AND 
    it_clientkey = ${client||(null)||String}$ AND 
    it_itdatetime_start = ${datetimestart||(null)||Timestamp}$
    ;
