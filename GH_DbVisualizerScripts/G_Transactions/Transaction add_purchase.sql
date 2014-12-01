select add_purchase(
        CAST(${numkey||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey), 
        CAST(${alphakey||null||String||nullable ds=10 dt=VARCHAR }$ AS ialphakey), 
        CAST(${buyer_name || null || String || nullable ds=10 dt=VARCHAR}$ AS clname), 
        CAST(${purchase_date|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS itdatetime), 
        CAST(${purchase_value || null || Float || nullable ds=10 dt=NUMERIC }$ AS itgross)
);

SELECT * FROM t_item_transactions WHERE
it_inumkey = CAST(${numkey||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey);

SELECT i_inumkey, i_ialphakey, i_clientkey FROM t_items WHERE
i_inumkey = CAST(${numkey||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey);

SELECT * FROM t_item_locations WHERE
ilo_inumkey = CAST(${numkey||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey);

SELECT * FROM t_exhibition_items WHERE
exi_inumkey = CAST(${numkey||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey);