BEGIN;
SELECT add_loan(CAST(${numkey||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey), 
        CAST(${alphakey||null||String||nullable ds=10 dt=VARCHAR }$ AS ialphakey), 
        CAST(${recipient_name || null || String || nullable ds=10 dt=VARCHAR}$ AS clname), 
        CAST(${lend_start|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS itdatetime,
        CAST(${return_by|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS itdatetime
);