BEGIN;
SELECT 
sell_item(
        CAST(${NUMBER||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey), 
        CAST(${CODE||null||String||nullable ds=10 dt=VARCHAR }$ AS ialphakey), 
        CAST(${client_name || null || String || nullable ds=10 dt=VARCHAR}$ AS clname), 
        CAST(${sale_date|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS itdatetime), 
        CAST(${value || null || Float || nullable ds=10 dt=NUMERIC }$ AS itgross)
);
