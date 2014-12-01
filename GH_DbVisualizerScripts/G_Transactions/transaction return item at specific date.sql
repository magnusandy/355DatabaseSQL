select itemReturned(
CAST(${NUMBER||null||BigDecimal||nullable ds=22 dt=NUMERIC }$ AS inumkey), 
CAST(${CODE||null||String||nullable ds=10 dt=VARCHAR }$ AS ialphakey), 
CAST(${date_returned yyyy-mm-dd hh:mm:ss|| null ||Timestamp||nullable ds=7 dt=TIMESTAMP }$ AS timestamp)
);