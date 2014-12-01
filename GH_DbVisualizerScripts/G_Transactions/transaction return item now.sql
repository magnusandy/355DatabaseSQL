select itemReturned(
CAST(${NUMBER||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey), 
CAST(${CODE||null||String||nullable ds=10 dt=VARCHAR }$ AS ialphakey), 
NULL
);