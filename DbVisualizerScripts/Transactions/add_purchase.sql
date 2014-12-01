BEGIN;
select 
add_purchase(
        CAST(${numkey||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey), 
        CAST(${alphakey||null||String||nullable ds=10 dt=VARCHAR }$ AS ialphakey), 
        CAST(${buyer_name || null || String || nullable ds=10 dt=VARCHAR}$ AS clname), 
        CAST(${purchase_date|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS itdatetime), 
        CAST(${amount_paid || null || Float || nullable ds=10 dt=NUMERIC }$ AS itgross)
);