create or replace function add_borrow(numkey inumkey,alphakey ialphakey, borrower clname, startDateTime itdatetime, dueDateTime itdatetime) returns void as $$ 
begin
if (numkey is null or alphakey is null) then
raise exception 'Error:You must have specified both the numkey and alphakey of the item';

elseif ((select count(*) from t_items where i_inumkey = numkey and i_ialphakey = alphakey) <= 0) then
raise exception 'Error:The alphakey does not match the numkey';

elseif (select borrower not in (select cl_clname from v_us)) then
raise exception 'Error: The item must be borrow by one of our museums: Iain, Ryans Museum, Evan Closson, Andrew Mueseum, or Walker Art Center';

elseif (select borrower in (select i_clientkey from t_items where i_inumkey = numkey)) then
raise exception 'Error: An owner of the item cannot borrow from himself';

end if;

-- Warn the user when an item is sold at midnight (they probably didn't specify a full date and time)
	IF ((SELECT EXTRACT(HOUR FROM CAST(startDateTime AS timestamp)) = 0) 
		AND (SELECT EXTRACT(MINUTE FROM CAST(startDateTime AS timestamp)) = 0) 
		AND (SELECT EXTRACT(SECOND FROM CAST(startDateTime AS timestamp)) = 0)) THEN
		RAISE NOTICE 'Warning: Lending item  at midnight, are you sure you specified a date and time?';
	
end if;

insert into t_item_transactions(it_inumkey, it_ialphakey, it_clientkey, it_clname_proprietor, it_ittype, it_itdatetime_start, it_itdatetime_returnby, it_clname_recipient, it_itgross)
VALUES(
numkey,
alphakey,
(select i_clientkey from t_items where i_inumkey = numkey),
(select i_clientkey from t_items where i_inumkey = numkey),
'Borrow',
startDateTime,
dueDateTime,
borrower,
0
);

end;
$$ language plpgsql;