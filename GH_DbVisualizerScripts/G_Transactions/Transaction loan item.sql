BEGIN;
select
add_loan(
CAST(${NUMBER||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey), 
CAST(${CODE||null||String||nullable ds=10 dt=VARCHAR }$ AS ialphakey),
CAST(${client_name || null || String || nullable ds=10 dt=VARCHAR}$ AS clname), 
CAST(${loan_date|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS itdatetime), 
CAST(${due_date|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS itdatetime)
);
       